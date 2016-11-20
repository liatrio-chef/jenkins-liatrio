#
# Cookbook Name:: jenkins-liatrio
# Recipe:: configure_mail
#
# Author: Drew Holt <drew@liatrio.com>
#

# load encrypted data bag
jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')

# configure administrator email and mail server configuration
jenkins_script 'configure mail' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()
    jenkinsLocationConfiguration.setAdminAddress("#{jenk_databag['email_address']}")
    jenkinsLocationConfiguration.save()

    import jenkins.model.*
    def inst = Jenkins.getInstance()
    def desc = inst.getDescriptor("hudson.tasks.Mailer")
    desc.setReplyToAddress("#{jenk_databag['email_address']}")
    desc.setSmtpHost("localhost")
    desc.setUseSsl(false)
    desc.setSmtpPort("25")
    desc.save()
   EOH
  notifies :create, 'ruby_block[set the mail_configured flag]', :immediately
  not_if { node.attribute?('mail_configured') || ::File.file?("#{node[:jenkins][:master][:home]}/mail_configured") }
end

# Set the security enabled flag and set the run_state to use the configured private key
ruby_block 'set the mail_configured flag' do
  block do
    node.set['mail_configured'] = true
    Chef::Config[:solo] ? ::FileUtils.touch("#{node[:jenkins][:master][:home]}/mail_configured") : node.save
  end
  action :nothing
end
