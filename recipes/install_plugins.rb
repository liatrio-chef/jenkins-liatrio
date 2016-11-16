#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_plugins
#
# Author: Drew Holt <drew@liatrio.com>
#

# load our encrypted data bag
jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')

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

# create the admin_id_rsa so the next blocks can use jenkins_crypt.sh
# to encrypt our jenkins secrets
file "#{node[:jenkins][:master][:home]}/admin_id_rsa" do
  content  jenk_databag['admin_id_rsa']
  mode     '0400'
  owner    'root'
  group    'root'
  sensitive true
end

# groovy script run from bash to get the crypted value to put in jenkins xml
cookbook_file "#{node[:jenkins][:master][:home]}/jenkins_crypt.sh" do
  source 'jenkins_crypt.sh'
  mode '0700'
  owner 'root'
  group 'root'
end
