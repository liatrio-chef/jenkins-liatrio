#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_chefdk
#
# Author: Drew Holt <drew@liatrio.com
#

# install chefdk-0.16.28 for el7
execute 'install chefdk' do
  command 'rpm -Uvh https://packages.chef.io/stable/el/7/chefdk-0.16.28-1.el7.x86_64.rpm'
  not_if 'rpm -qa chefdk | grep chefdk'
end

execute 'install knife-spork gem for chef omnibus' do
  command 'chef gem install --no-user-install knife-spork'
  not_if 'chef gem list | grep knife-spork'
end

execute 'install slack-notifier gem for chef omnibus' do
  command 'chef gem install --no-user-install slack-notifier'
  not_if 'chef gem list | grep slack-notifer'
end
