#
# Cookbook Name:: jenkins_liatrio
# Attributes:: create_job
#
# Author: Drew Holt <drew@liatrio.com>
#

default[:jenkins_liatrio][:create_job][:maven_goals] = 'clean install'
default[:jenkins_liatrio][:nexus_repo] = 'nexus.local'
