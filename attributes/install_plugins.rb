#
# Cookbook Name:: jenkins
# Attributes:: install_plugins
#
# Author: Drew Holt <drew@liatrio.com>
#

default[:jenkins_liatrio][:install_plugins][:plugins_list] = %w(google-login=1.3 ace-editor=1.1 aws-java-sdk=1.11.37
bouncycastle-api=2.16.0 branch-api=1.11 cloudbees-folder=5.13 conditional-buildstep=1.3.5 copyartifact=1.38.1
 credentials=2.1.8 display-url-api=0.5 durable-task=1.12 git=3.0.0 git-client=2.0.0 git-server=1.7 github=1.22.3
 github-api=1.79 handlebars=1.1.1 icon-shim=2.0.3 jackson2-api=2.7.3 javadoc=1.4 job-dsl=1.52 jquery=1.11.2-0
 jquery-detached=1.2.1 junit=1.19 mailer=1.18 matrix-auth=1.4 matrix-project=1.7.1 maven-plugin=2.14
 momentjs=1.1.1 naginator=1.17.2 parameterized-trigger=2.32 pipeline-build-step=2.3 pipeline-graph-analysis=1.1
 pipeline-input-step=2.3 pipeline-milestone-step=1.1 pipeline-rest-api=2.2 pipeline-stage-step=2.2
 pipeline-stage-view=2.0 plain-credentials=1.3 run-condition=1.0 s3=0.10.10 scm-api=1.3 script-security=1.24
 sonar=2.5 ssh-credentials=1.12 structs=1.5 token-macro=2.0 workflow-aggregator=2.4 workflow-api=2.5
 workflow-basic-steps=2.3 workflow-cps=2.17 workflow-cps-global-lib=2.3 workflow-durable-task-step=2.5
 workflow-job=2.8 workflow-multibranch=2.8 workflow-scm-step=2.2 workflow-step-api=2.5 workflow-support=2.10
 credentials-binding=1.10 windows-slaves=1.2 antisamy-markup-formatter=1.5 pam-auth=1.3 nodejs=0.2.1 slack=2.0.1
 ldap=1.13 ansicolor=0.4.2 build-pipeline-plugin=1.5.4 greenballs=1.15 ssh-agent=1.13 external-monitor-job=1.6)
default[:jenkins_liatrio][:install_plugins][:enablearchiva] = false
default[:jenkins_liatrio][:install_plugins][:enablesonar] = false
default[:jenkins_liatrio][:install_plugins][:enablearchiva] = false
default[:jenkins_liatrio][:install_plugins][:sonarurl] = 'http://localhost:9000'
default[:jenkins_liatrio][:install_plugins][:sonarjdbcurl] = 'tcp://localhost:9092/sonar'
default[:jenkins_liatrio][:install_plugins][:jenkinsdlurl] = 'http://pkg.jenkins-ci.org/redhat/jenkins-1.653-1.1.noarch.rpm'
default[:jenkins_liatrio][:install_plugins][:githuburl] = 'https://github.com/drewliatro/spring-petclinic/'
default[:jenkins_liatrio][:install_plugins][:giturl] = 'https://github.com/drew-liatrio/spring-petclinic.git'
default[:jenkins_liatrio][:install_plugins][:hygieia_url] = 'http://192.168.100.10:8080/api/'

# default[:jenkins][:nexus_repo]                 = "nexus.local"
# default[:jenkins][:job_name]                   = "petclinic-auto-1"
