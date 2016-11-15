#
# Cookbook Name:: jenkins-liatrio
# Recipe:: plugin_slack.rb
#
# Author: Justin Bankes <justin@liatrio.com>
#

# load our encrypted data bag
jenk_databag = Chef::EncryptedDataBagItem.load("jenkins", "cred")

# jenkins config for slack
template "#{node[:jenkins][:master][:home]}/jenkins.plugins.slack.SlackNotifier.xml" do
  source   "jenkins.plugins.slack.SlackNotifier.xml.erb"
  mode     "0644"
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables(slack_token: jenk_databag["slack_token"],
            slack_teamdomain: jenk_databag["slack_teamdomain"],
            slack_room: jenk_databag["slack_room"],
            slack_buildserver: jenk_databag["slack_buildserver"])
  notifies :restart, "service[jenkins]", :delayed
  sensitive true
end
