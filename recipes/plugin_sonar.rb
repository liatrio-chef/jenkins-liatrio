#
# Cookbook Name:: jenkins-liatrio
# Recipe:: plugin_sonar
#
# Author: Drew Holt <drew@liatrio.com>
#

cookbook_file '/var/lib/jenkins/sonar-runner-dist-2.4.zip' do
  source 'sonar-runner-dist-2.4.zip'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  mode '0644'
  action :create
end

execute 'unzip_sonar-runner' do
  command 'cd /var/lib/jenkins; unzip sonar-runner-dist-2.4.zip'
  not_if { ::File.exist?('/var/lib/jenkins/sonar-runner-2.4') }
end

template '/var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml' do
  source   'hudson.plugins.sonar.SonarPublisher.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

template '/var/lib/jenkins/hudson.plugins.sonar.SonarGlobalConfiguration.xml' do
  source   'hudson.plugins.sonar.SonarGlobalConfiguration.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

template '/var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml' do
  source   'hudson.plugins.sonar.SonarRunnerInstallation.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

template '/var/lib/jenkins/sonar-runner-2.4/conf/sonar-runner.properties' do
  source   'sonar-runner-2.4/conf/sonar-runner.properties.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end
