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

cookbook_file '/var/lib/jenkins/sonar-runner-dist-2.4.zip' do
  source 'sonar-runner-dist-2.4.zip'
  owner 'root'
  group 'root'
  mode '0666'
  action :create
end

execute 'unzip_sonar-runner' do
  command 'cd /var/lib/jenkins; unzip sonar-runner-dist-2.4.zip'
  not_if do ::File.exists?('/var/lib/jenkins/sonar-runner-2.4') end
end

template '/var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml' do
  source   'var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml.erb'
  mode     '0755'
  variables({})
end

template '/var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml' do
  source   'var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml.erb'
  mode     '0755'
  variables({})
end

template '/var/lib/jenkins/sonar-runner-2.4/conf/sonar-runner.properties' do
  source   'var/lib/jenkins/sonar-runner-2.4/conf/sonar-runner.properties.erb'
  mode     '0755'
  variables({})
end

cookbook_file '/var/lib/jenkins/hygieia-publisher.hpi' do
  source 'hygieia-publisher.hpi'
  owner 'jenkins'
  group 'jenkins'
  mode '0666'
  action :create
end

execute 'install-plugin-hygieia-publisher' do
  command "java -jar /opt/jenkins-cli.jar -s http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/ install-plugin /var/lib/jenkins/hygieia-publisher.hpi"
  not_if ("java -jar /opt/jenkins-cli.jar -s http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/ list-plugins| grep hygieia-publisher")
end

template '/var/lib/jenkins/jenkins.plugins.hygieia.HygieiaPublisher.xml' do
  source   'var/lib/jenkins/jenkins.plugins.hygieia.HygieiaPublisher.xml.erb'
  mode     '0755'
  variables({})
end
