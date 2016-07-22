#
# Cookbook Name:: jenkins_liatrio
# Attributes:: default
#
# Author: Drew Holt <drew@liatrio.com>
#

default[:jenkins_liatrio][:packages]              = %w{java-1.8.0-openjdk-devel java-1.8.0-openjdk maven maven-war-plugin git wget}
default[:jenkins_liatrio][:sleep_interval_small]  = 3
default[:jenkins_liatrio][:maven_mirror]      = "http://localhost:8081/repository/internal"
