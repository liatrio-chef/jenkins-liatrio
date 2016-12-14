
#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_plugins_pipeline
#
# Author: Drew Holt <drew@liatrio.com>
#

cookbook_file "#{node['jenkins']['master']['home']}/sonar-runner-dist-2.4.zip" do
  source 'sonar-runner-dist-2.4.zip'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  mode '0644'
  action :create
end

execute 'unzip_sonar-runner' do
  command "cd #{node['jenkins']['master']['home']}; unzip sonar-runner-dist-2.4.zip"
  not_if { ::File.exist?("#{node['jenkins']['master']['home']}/sonar-runner-2.4") }
end

template "#{node['jenkins']['master']['home']}/hudson.plugins.sonar.SonarPublisher.xml" do
  source   'hudson.plugins.sonar.SonarPublisher.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

template "#{node['jenkins']['master']['home']}/hudson.plugins.sonar.SonarRunnerInstallation.xml" do
  source   'hudson.plugins.sonar.SonarRunnerInstallation.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

template "#{node['jenkins']['master']['home']}//sonar-runner-2.4/conf/sonar-runner.properties" do
  source   'sonar-runner-2.4/conf/sonar-runner.properties.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

if node[:jenkins_liatrio][:install_plugins][:enablearchiva] == true
  template "#{node['jenkins']['master']['home']}/.m2/settings.xml" do
    source '.m2/settings.xml.erb'
    mode '0644'
    owner node[:jenkins][:user]
    group node[:jenkins][:group]
    variables({})
    notifies :restart, 'service[jenkins]', :delayed
  end
end
