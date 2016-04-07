#
# Cookbook Name:: jenkins_liatrio
# Attributes:: default
#
# Author: Drew Holt <drew@liatrio.com>
#

default[:jenkins_liatrio][:packages]              = ['java-1.8.0-openjdk-devel','java-1.8.0-openjdk','maven','maven-war-plugin']
default[:jenkins_liatrio][:sleep_interval_small]  = 3
