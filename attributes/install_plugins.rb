#
# Cookbook Name:: jenkins
# Attributes:: install_plugins
#
# Author: Drew Holt <drew@liatrio.com>
#

default[:jenkins_liatrio][:install_plugins][:plugins_list]      = ['git','github','naginator','sonar']

default[:jenkins][:install_plugins][:maven_mirror]	= "http://localhost:8081/repository/internal"
default[:jenkins][:install_plugins][:sonarurl]		  = "http://localhost:9000"
default[:jenkins][:install_plugins][:sonarjdbcurl]	= "tcp://localhost:9092/sonar"
default[:jenkins][:install_plugins][:jenkinsdlurl]	= "http://pkg.jenkins-ci.org/redhat/jenkins-1.653-1.1.noarch.rpm"
default[:jenkins][:install_plugins][:githuburl]     = "https://github.com/drewliatro/spring-petclinic/"
default[:jenkins][:install_plugins][:giturl]		    = "https://github.com/drew-liatrio/spring-petclinic.git"
default[:jenkins][:install_plugins][:jenkinsdlurl]  = "http://pkg.jenkins-ci.org/redhat-stable/jenkins-1.642.3-1.1.noarch.rpm"
default[:jenkins][:install_plugins][:hygieia_url]   = "http://192.168.100.10:8080/api/"

#default[:jenkins][:nexus_repo]                 = "nexus.local"
#default[:jenkins][:job_name]                   = "petclinic-auto-1"
