#
# Cookbook Name:: jenkins-liatrio
# Recipe:: plugin_s3
#
# Author: Drew Holt <drew@liatrio.com>
#

# load our encrypted data bag
jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')

# create the jenkins encrypted aws secretkey as an attribute
ruby_block 'generate_databasesecret_crypt_secretkey' do
  block do
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
    command = "#{node[:jenkins][:master][:home]}/jenkins_crypt.sh #{jenk_databag['secretkey']}"
    command_out = shell_out(command)
    node.set[:jenkins_liatrio][:secretkey] = command_out.stdout
  end
  sensitive true
end

# XXX we need to use string.strip on this, how ever it breaks ChefSpec
# secretkey_stripped = node[:jenkins_liatrio][:secretkey].strip
secretkey_stripped = node[:jenkins_liatrio][:secretkey]

# jenkins config for aws s3
template "#{node[:jenkins][:master][:home]}/hudson.plugins.s3.S3BucketPublisher.xml" do
  source   'hudson.plugins.s3.S3BucketPublisher.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables(accesskey: jenk_databag['accesskey'],
            secretkey: secretkey_stripped)
  notifies :restart, 'service[jenkins]', :delayed
  sensitive true
end
