#
# Cookbook Name:: jenkins
# Attributes:: install_plugins
#
# Author: Drew Holt <drew@liatrio.com>
#

default[:jenkins_liatrio][:install_plugins][:plugins_list]  = %w(ace-editor=1.1 ansicolor=0.4.3 antisamy-markup-formatter=1.5 authentication-tokens=1.3 aws-java-sdk=1.11.68 blueocean-autofavorite=0.6 blueocean-commons=1.0.0-b23 blueocean-config=1.0.0-b23 blueocean-dashboard=1.0.0-b23 blueocean-display-url=1.5.1 blueocean-events=1.0.0-b23 blueocean-git-pipeline=1.0.0-b23 blueocean-github-pipeline=1.0.0-b23 blueocean-i18n=1.0.0-b23 blueocean-jwt=1.0.0-b23 blueocean-personalization=1.0.0-b23 blueocean-pipeline-api-impl=1.0.0-b23 blueocean-rest-impl=1.0.0-b23 blueocean-rest=1.0.0-b23 blueocean-web=1.0.0-b23 blueocean=1.0.0-b23 bouncycastle-api=2.16.0 branch-api=2.0.6 build-pipeline-plugin=1.5.6 cloudbees-folder=5.17 conditional-buildstep=1.3.5 config-file-provider=2.15.6 copyartifact=1.38.1 credentials-binding=1.10 credentials=2.1.11 display-url-api=1.1.1 docker-commons=1.6 docker-workflow=1.10 durable-task=1.13 external-monitor-job=1.7 favorite=2.0.4 git-client=2.2.1 git-server=1.7 git=3.0.5 github-api=1.84 github-branch-source=2.0.3 github-organization-folder=1.6 github=1.26.0 google-login=1.3 greenballs=1.15 handlebars=1.1.1 icon-shim=2.0.3 jackson2-api=2.7.3 javadoc=1.4 job-dsl=1.58 jquery-detached=1.2.1 jquery=1.11.2-0 junit=1.20 ldap=1.14 mailer=1.19 matrix-auth=1.4 matrix-project=1.8 maven-plugin=2.15.1 metrics=3.1.2.9 momentjs=1.1.1 naginator=1.17.2 nodejs=1.1.1 pam-auth=1.3 parameterized-trigger=2.32 pipeline-build-step=2.4 pipeline-github-lib=1.0 pipeline-graph-analysis=1.3 pipeline-input-step=2.5 pipeline-milestone-step=1.3 pipeline-model-api=1.0.1 pipeline-model-declarative-agent=1.0.1 pipeline-model-definition=1.0.1 pipeline-rest-api=2.5 pipeline-stage-step=2.2 pipeline-stage-tags-metadata=1.0.1 pipeline-stage-view=2.5 plain-credentials=1.4 pubsub-light=1.7 run-condition=1.0 s3=0.10.11 scm-api=2.0.7 script-security=1.26 slack=2.1 sonar=2.5 sse-gateway=1.15 ssh-agent=1.14 ssh-credentials=1.13 structs=1.6 token-macro=2.0 variant=1.1 windows-slaves=1.2 workflow-aggregator=2.5 workflow-api=2.11 workflow-basic-steps=2.4 workflow-cps-global-lib=2.6 workflow-cps=2.27 workflow-durable-task-step=2.9 workflow-job=2.10 workflow-multibranch=2.12 workflow-scm-step=2.3 workflow-step-api=2.9 workflow-support=2.13)
default[:jenkins_liatrio][:install_plugins][:enablearchiva]	= false
default[:jenkins_liatrio][:install_plugins][:enablesonar]	= false
default[:jenkins_liatrio][:install_plugins][:enablearchiva]	= false
default[:jenkins_liatrio][:install_plugins][:sonarurl] = 'http://localhost:9000'
default[:jenkins_liatrio][:install_plugins][:sonarjdbcurl]	= 'tcp://localhost:9092/sonar'
default[:jenkins_liatrio][:install_plugins][:jenkinsdlurl]	= 'http://pkg.jenkins-ci.org/redhat/jenkins-1.653-1.1.noarch.rpm'
default[:jenkins_liatrio][:install_plugins][:githuburl] = 'https://github.com/drewliatro/spring-petclinic/'
default[:jenkins_liatrio][:install_plugins][:giturl] = 'https://github.com/drew-liatrio/spring-petclinic.git'
default[:jenkins_liatrio][:install_plugins][:hygieia_url] = 'http://192.168.100.10:8080/api/'

# default[:jenkins][:nexus_repo]                 = "nexus.local"
# default[:jenkins][:job_name]                   = "petclinic-auto-1"
