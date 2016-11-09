#
# Cookbook Name:: jenkins-liatrio
# Recipe:: m2_settings
#
# Author: Drew Holt <drew@liatrio.com>
#

# create our .m2 directory for maven settings
directory '/var/lib/jenkins/.m2' do
  action :create
  recursive true
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  mode '0755'
end

# add our settings.xml to the .m2 directory
template '/var/lib/jenkins/.m2/settings.xml' do
  source '.m2/settings.xml.erb'
  mode '0600'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
  notifies :restart, 'service[jenkins]', :delayed
end
