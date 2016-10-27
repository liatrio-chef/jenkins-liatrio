#
# Cookbook Name:: jenkins-liatrio
# Recipe:: default
#
# Author: Drew Holt <drew@liatrio.com>
#


# Included English based of information found in this issue at github 
# https://github.com/bbatsov/rubocop/issues/1747
require 'English'

node[:jenkins_liatrio][:packages].each do |pkg|
  package pkg
end

include_recipe 'jenkins::master'

directory '/var/lib/jenkins/.m2' do
  action :create
  recursive true
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  mode '0755'
end

template '/etc/maven/settings.xml' do
  source   'etc/maven/settings.xml.erb'
  mode     '0755'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
end

ruby_block 'before_wait_for_jenkins' do
  block do
    loop do
      puts "curl http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/jnlpJars/jenkins-cli.jar"
      ` curl http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/jnlpJars/jenkins-cli.jar -X HEAD -I -s | grep "200 OK" `
      exitstatus = $CHILD_STATUS.exitstatus
      (puts '+++ +++ before_wait_for_jenkins should exit!' && break) if 0 == exitstatus
      puts '+++ +++ Sleeping in before_wait_for_jenkins...'
      sleep node[:jenkins_liatrio][:sleep_interval_small]
    end
  end
  # notifies :run, 'execute[get_jenkins_cli_jar]', :immediately
end

execute 'get_jenkins_cli_jar' do
  command "wget http://#{node[:jenkins][:master][:host]}:#{node[:jenkins][:master][:port]}/jnlpJars/jenkins-cli.jar"
  cwd '/opt'
  not_if { ::File.exist?('/opt/jenkins-cli.jar') }
end
