#
# Cookbook Name:: jenkins-liatrio
# Recipe:: default
#
# Author: Drew Holt <drew@liatrio.com>
#
require 'English'

# install java
# XXX take a decision on if we want to manage node attributes in the recipe.rb
# or manage it in 3 places on chef server, vagrantfile, and test kitchen
include_recipe 'java::default'

# we need epel for nodejs, ruby, etc
include_recipe 'yum-epel::default'

execute 'run init if in docker' do
  command '/usr/sbin/init'
  not_if 'ps aux | grep init'
end

# we need swap
#swap_file '/var/swapfile' do
#  size 4096
#end

# install os packages needed for jenkins via yum
node[:jenkins_liatrio][:packages].each do |pkg|
  package pkg
end

# Set this on the chef server for the build server, otherwise don't run it in Vagrant for 1.x
# Disable Jenkins 2.0 setup wizard until issue fixed: https://github.com/chef-cookbooks/jenkins/pull/471
# node.default["jenkins"]["master"]["jvm_options"] = "-Djenkins.install.runSetupWizard=false"

# set this as an attribute on the Chef server to "2.28-1.1", otherwise
# default vagrant will install latest 1.x in the chef.json run list
# node.default["jenkins"]["master"]["version"] = "2.28-1.1"

# use community jenkins recipe to install jenkins
include_recipe 'jenkins::master'

# sleep while waiting for jenkins service to become active
ruby_block 'before_wait_for_jenkins' do
  block do
    loop do
      puts "curl http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/jnlpJars/jenkins-cli.jar"
      `curl http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/jnlpJars/jenkins-cli.jar -X HEAD -I -s | grep "200 OK"`
      exitstatus = $CHILD_STATUS.exitstatus
      (puts '+++ +++ before_wait_for_jenkins should exit!' && break) if exitstatus.zero?
      puts '+++ +++ Sleeping in before_wait_for_jenkins...'
      sleep node[:jenkins_liatrio][:sleep_interval_small]
    end
  end
  # notifies :run, 'execute[get_jenkins_cli_jar]', :immediately
end

# download jenkins-cli.jar into /opt
remote_file '/opt/jenkins-cli.jar' do
  action :create_if_missing
  source "http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/jnlpJars/jenkins-cli.jar"
  # not_if { ::File.exist?('/opt/jenkins-cli.jar') }
end
