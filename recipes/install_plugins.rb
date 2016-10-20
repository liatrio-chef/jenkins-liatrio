#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_plugins
#
# Author: Drew Holt <drew@liatrio.com>
#

# install plugins
node[:jenkins_liatrio][:install_plugins][:plugins_list].each do |i|
  jenkins_plugin i
end

# link maven
template '/var/lib/jenkins/hudson.tasks.Maven.xml' do
  source   'var/lib/jenkins/hudson.tasks.Maven.xml.erb'
  mode     '0755'
  variables({})
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  notifies :restart, 'service[jenkins]', :delayed
end
