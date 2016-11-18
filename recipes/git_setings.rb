#
# Cookbook Name:: jenkins-liatrio
# Recipe:: git_settngs
#
# Author: Drew Holt <drew@liatrio.com>
#

# ~/.gitconfig settings
template "#{node[:jenkins][:master][:home]}/.gitconfig" do
  source   '.gitconfig.erb'
  mode     '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables()
end
