#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_plugins_pipeline
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
  source   'var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

template '/var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml' do
  source   'var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

template '/var/lib/jenkins/sonar-runner-2.4/conf/sonar-runner.properties' do
  source   'var/lib/jenkins/sonar-runner-2.4/conf/sonar-runner.properties.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({})
end

if node[:jenkins_liatrio][:install_plugins][:enablearchiva] == true
  template '/var/lib/jenkins/.m2/settings.xml' do
    source 'var/lib/jenkins/.m2/settings.xml.erb'
    mode '0644'
    owner node[:jenkins][:user]
    group node[:jenkins][:group]
    variables({})
    notifies :restart, 'service[jenkins]', :delayed
  end
end
