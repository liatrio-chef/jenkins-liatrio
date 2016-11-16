#
# Cookbook Name:: jenkins-liatrio
# Attributes:: job_seed_automation
#
# Author: Drew Holt <drew@liatrio.com>
#

# Create AutomationManagementJob seed job
template "#{node[:jenkins][:master][:home]}/jobs/AutomationManagementJob-config.xml" do
  source 'jobs/AutomationManagementJob-config.xml.erb'
  mode '0644'
  owner node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
  variables({
            })
end

jenkins_job 'AutomationManagementJob' do
  config "#{node[:jenkins][:master][:home]}/jobs/AutomationManagementJob-config.xml"
  action [:create, :build]
  not_if { ::File.exist?("#{node[:jenkins][:master][:home]}/jobs/AutomationManagementJob/config.xml") }
end
