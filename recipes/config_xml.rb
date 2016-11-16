#
# Cookbook Name:: jenkins-liatrio
# Recipe:: config_xml
#
# Author: Drew Holt <drew@liatrio.com>
#

# load encrypted data bag
jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')

# add our config.xml last in the run list
template "#{node[:jenkins][:master][:home]}/config.xml" do
  source   'config.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables(git_auth_token: jenk_databag['git_auth_token']
           )
  notifies :restart, 'service[jenkins]', :delayed
end
