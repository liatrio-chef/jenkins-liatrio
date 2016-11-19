#
# Cookbook Name:: jenkins-liatrio
# Recipe:: apache2
#
# Author: Drew Holt <drew@liatrio.com>
#

# load our encrypted data bags
jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')
site_fqdn = jenk_databag['site_fqdn']

# 443 added for ssl support, 80 by default
node.default['apache2']['listen'] = ['*:80', '*:443']

# run the following apache recipes
%w(apache2 apache2::mod_proxy apache2::mod_proxy_http apache2::mod_proxy_ajp apache2::mod_ssl).each do |recipe|
  include_recipe recipe.to_s
end

file "#{node['apache']['dir']}/ssl/#{site_fqdn}.ca-bundle" do
  content jenk_databag["#{site_fqdn}.cabundle"]
  user 'root'
  group 'root'
  mode 0o400
  sensitive true
  notifies :restart, 'service[apache2]', :delayed
end

file "#{node['apache']['dir']}/ssl/#{site_fqdn}.crt" do
  content jenk_databag["#{site_fqdn}.crt"]
  user 'root'
  group 'root'
  mode 0o400
  sensitive true
  notifies :restart, 'service[apache2]', :delayed
end

file "#{node['apache']['dir']}/ssl/#{site_fqdn}.csr" do
  content jenk_databag["#{site_fqdn}.csr"]
  user 'root'
  group 'root'
  mode 0o400
  sensitive true
  notifies :restart, 'service[apache2]', :delayed
end

file "#{node['apache']['dir']}/ssl/#{site_fqdn}.key" do
  content jenk_databag['sslkey']
  user 'root'
  group 'root'
  mode 0o400
  sensitive true
  notifies :restart, 'service[apache2]', :delayed
end

# updated our ssl.conf with site specifics
template "#{node['apache']['dir']}/conf-enabled/ssl.conf" do
  source 'ssl.conf.erb'
  mode 0o644
  owner 'root'
  group 'root'
  variables(
    sslcertificate: "#{node['apache']['sslpath']}/#{site_fqdn}.crt",
    sslkey: "#{node['apache']['sslpath']}/#{site_fqdn}.key",
    sslcacertificate: "#{node['apache']['sslpath']}/#{site_fqdn}.ca-bundle",
    servername: site_fqdn.to_s
  )
  notifies :restart, 'service[apache2]', :delayed
end

# install jenkins.conf to sites-enabled
web_app 'jenkins' do
  template 'jenkins.conf.erb'
end
