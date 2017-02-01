#
# ChefSpec for jenkins-liatrio
# Recipe: configure_mail
# Author: Justin Bankes justin@liatrio.com
#

# Currently this recipe doesn't have anything running in it.
require 'spec_helper'

describe 'jenkins-liatrio::install_chefdk' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    stub_command("rpm -qa chefdk | grep chefdk").and_return(false)
    stub_command("chef gem list | grep knife-spork").and_return(false)
    stub_command("chef gem list | grep slack-notifer").and_return(false)
  end

  it 'Installs ChefDK version 0.16.28' do
    expect(chef_run).to run_execute('install chefdk').with(
      command: 'rpm -Uvh https://packages.chef.io/stable/el/7/chefdk-0.16.28-1.el7.x86_64.rpm'
    )
  end

  it 'Installs knife-spork gem for chef omnibus' do
    expect(chef_run).to run_execute('install knife-spork gem for chef omnibus').with(
      command: 'chef gem install --no-user-install knife-spork'
    )
  end

  it 'Install slack-notifier gem for chef omnibus' do
    expect(chef_run).to run_execute('install slack-notifier gem for chef omnibus').with(
      command: 'chef gem install --no-user-install slack-notifier'
    )
  end

end
