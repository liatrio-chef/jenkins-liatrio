#
# Cookbook Name:: jenkins_liatrio
# Attributes:: default
#
# Author: Drew Holt <drew@liatrio.com>
#

default[:jenkins_liatrio][:packages]              = ['java-1.8.0-openjdk-devel','java-1.8.0-openjdk','maven','maven-war-plugin']
default[:jenkins_liatrio][:user]                  = 'jenkins'
default[:jenkins_liatrio][:group]                 = 'jenkins'
default[:jenkins_liatrio][:ip]                    = '127.0.0.1'
default[:jenkins_liatrio][:port]                  = '8080'
default[:jenkins_liatrio][:sleep_interval_small]  = 3
