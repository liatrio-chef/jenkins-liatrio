#
# Cookbook Name:: jenkins-liatrio
# Attributes:: create_job
#
# Author: Drew Holt <drew@liatrio.com>
#

# Create petclinic-simple job
template '/var/lib/jenkins/jobs/petclinic-simple-config.xml' do
  source 'var/lib/jenkins/jobs/petclinic-simple-config.xml.erb'
  mode '0644'
  variables({
    :nexus_repo => node[:jenkins_liatrio][:nexus_repo]
  })
end

jenkins_job 'petclinic-simple' do
  config '/var/lib/jenkins/jobs/petclinic-simple-config.xml'
end

# Create deploy-tomcat job
template '/var/lib/jenkins/jobs/deploy-tomcat-config.xml' do
  source 'var/lib/jenkins/jobs/deploy-tomcat-config.xml.erb'
  mode '0644'
  variables({
  })
end

jenkins_job 'deploy-tomcat' do
  config '/var/lib/jenkins/jobs/deploy-tomcat-config.xml'
end
