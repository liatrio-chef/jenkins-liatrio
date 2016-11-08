#
# Cookbook Name:: jenkins-liatrio
# Recipe:: plugin_maven
#
# Author: Drew Holt <drew@liatrio.com>
#

# jenkins configuration for maven
template "#{node[:jenkins][:master][:home]}/hudson.tasks.Maven.xml" do
  source   "hudson.tasks.Maven.xml.erb"
  mode     "0755"
  variables({})
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  notifies :restart, "service[jenkins]", :delayed
end
