#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_plugins_hygieia
#
# Author: Drew Holt <drew@liatrio.com>
#

cookbook_file "#{node['jenkins']['master']['home']}//hygieia-publisher.hpi" do
  source 'hygieia-publisher.hpi'
  mode '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  action :create
end

execute 'install-plugin-hygieia-publisher' do
  command "java -jar /opt/jenkins-cli.jar -s http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/ install-plugin /var/lib/jenkins/hygieia-publisher.hpi"
  not_if "java -jar /opt/jenkins-cli.jar -s http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/ list-plugins| grep hygieia-publisher"
end

template "#{node['jenkins']['master']['home']}//jenkins.plugins.hygieia.HygieiaPublisher.xml" do
  source   'jenkins.plugins.hygieia.HygieiaPublisher.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end
