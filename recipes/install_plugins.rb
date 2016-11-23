#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_plugins
#
# Author: Drew Holt <drew@liatrio.com>
#

# create a blank file of plugins_installed on initial chef run
file "#{node['jenkins']['master']['home']}/plugins_installed" do
  mode '0644'
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  action :create
  not_if { ::File.exist?("#{node['jenkins']['master']['home']}/plugins_installed") }
end

# install plugins
node[:jenkins_liatrio][:install_plugins][:plugins_list].each do |plugin|
  plugin, version = plugin.split('=')
  jenkins_plugin plugin do
    version version if version
    install_deps false
  end
end

# based on attribute, write out a list of plugins. restart jenkins if the attribute changes
file "#{node['jenkins']['master']['home']}/plugins_installed" do
  content node['jenkins_liatrio']['install_plugins']['plugins_list'].map(&:inspect).join(',')
  mode '0644'
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  action :create
  notifies :restart, 'service[jenkins]', :immediately
  notifies :run, 'ruby_block[before_wait_for_jenkins]'
end
