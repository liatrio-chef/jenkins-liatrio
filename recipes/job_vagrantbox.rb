#
# Cookbook Name:: jenkins-liatrio
# Attributes:: job_vagrantbox
#
# Author: Drew Holt <drew@liatrio.com>
#

# Create petclinic-simple job
template '/var/lib/jenkins/jobs/petclinic-simple-config.xml' do
  source 'jobs/petclinic-simple-config.xml.erb'
  mode '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables(nexus_repo: node[:jenkins_liatrio][:nexus_repo])
end

jenkins_job 'petclinic-simple-auto-1' do
  config '/var/lib/jenkins/jobs/petclinic-simple-config.xml'
end

# Create deploy-tomcat job
template '/var/lib/jenkins/jobs/deploy-tomcat-config.xml' do
  source 'jobs/deploy-tomcat-config.xml.erb'
  mode '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({
            })
end

jenkins_job 'deploy-tomcat' do
  config '/var/lib/jenkins/jobs/deploy-tomcat-config.xml'
end

# selenium-chrome-petclinic-test
template '/var/lib/jenkins/jobs/selenium-chrome-petclinic-test-config.xml' do
  source 'jobs/selenium-chrome-petclinic-test-config.xml.erb'
  mode '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({
            })
end

jenkins_job 'selenium-chrome-petclinic-test' do
  config '/var/lib/jenkins/jobs/selenium-chrome-petclinic-test-config.xml'
end

# selenium-firefox-petclinic-test
template '/var/lib/jenkins/jobs/selenium-firefox-petclinic-test-config.xml' do
  source 'jobs/selenium-firefox-petclinic-test-config.xml.erb'
  mode '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({
            })
end

jenkins_job 'selenium-firefox-petclinic-test' do
  config '/var/lib/jenkins/jobs/selenium-firefox-petclinic-test-config.xml'
end
