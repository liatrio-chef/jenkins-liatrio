#
# Cookbook Name:: jenkins-liatrio
# Attributes:: job_chef_seed_automation.rb
#
# Author: Drew Holt <drew@liatrio.com>
#

# Create chef-automation-seed-job
template "#{node['jenkins']['master']['home']}/jobs/chef-automation-seed-job.xml" do
  source 'jobs/chef-automation-seed-job.xml.erb'
  mode '0644'
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  variables({
            })
end

jenkins_job 'chef-automation-seed-job' do
  config "#{node['jenkins']['master']['home']}/jobs/chef-automation-seed-job.xml"
end
