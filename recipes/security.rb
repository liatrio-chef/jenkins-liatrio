#
# Cookbook Name:: jenkins-liatrio
# Recipe:: security
#
# Author: Drew Holt <drew@liatrio.com>
#

jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')
admin_id_rsa = jenk_databag['admin_id_rsa']
admin_id_rsa_pub = jenk_databag['admin_id_rsa_pub']
admin_password = jenk_databag['admin_password']

# we need mailer-plugin installed first for this to work
jenkins_plugin 'mailer' do
  action :install
  version '1.18'
  notifies :restart, 'service[jenkins]', :immediately
  not_if { ::File.file?("#{node[:jenkins][:master][:home]}/plugins/mailer.jpi") }
end

# lock jenkins down
# pulled from http://pghalliday.com/jenkins/groovy/sonar/chef/configuration/management/2014/09/21/some-useful-jenkins-groovy-scripts.html

# If security was enabled in a previous chef run then set the private key in the run_state
# now as required by the Jenkins cookbook
ruby_block 'set jenkins private key' do
  block do
    node.run_state[:jenkins_private_key] = admin_id_rsa
  end
  only_if { node.attribute?('security_enabled') || ::File.file?("#{node[:jenkins][:master][:home]}/security_enabled") }
end

# Add the admin user only if it has not been added already then notify the resource
# to configure the permissions for the admin user
jenkins_user 'admin' do
  admin_id_rsa_pub_key = admin_id_rsa_pub.to_s
  password admin_password
  public_keys [admin_id_rsa_pub_key.to_s]
  not_if { node.attribute?('security_enabled') || ::File.file?("#{node[:jenkins][:master][:home]}/security_enabled") }
  notifies :execute, 'jenkins_script[configure_permissions]', :immediately
  sensitive true
end

# Configure the permissions so that login is required and the admin user is an administrator
# after this point the private key will be required to execute jenkins scripts (including querying
# if users exist) so we notify the `set the security_enabled flag` resource to set this up.
# Also note that since Jenkins 1.556 the private key cannot be used until after the admin user
# has been added to the security realm
jenkins_script 'configure_permissions' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    import hudson.security.*
    def instance = Jenkins.getInstance()
    def hudsonRealm = new HudsonPrivateSecurityRealm(false)
    instance.setSecurityRealm(hudsonRealm)
    def strategy = new GlobalMatrixAuthorizationStrategy()
    strategy.add(Jenkins.ADMINISTER, "admin")
    instance.setAuthorizationStrategy(strategy)
    instance.save()
  EOH
  notifies :create, 'ruby_block[set the security_enabled flag]', :immediately
  action :nothing
end

# Set the security enabled flag and set the run_state to use the configured private key
ruby_block 'set the security_enabled flag' do
  block do
    node.run_state[:jenkins_private_key] = admin_id_rsa
    node.set['security_enabled'] = true
    Chef::Config[:solo] ? ::FileUtils.touch("#{node[:jenkins][:master][:home]}/security_enabled") : node.save
  end
  action :nothing
end
