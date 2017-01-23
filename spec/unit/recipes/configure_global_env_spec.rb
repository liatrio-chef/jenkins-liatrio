# Cookbook Name: jenkins-liatrio
# Spec::default
require 'spec_helper'

describe 'jenkins-liatrio::configure_global_env' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('jenkins', 'cred').and_return(
      'GIT_AUTH_TOKEN' => 'random'
    )
  end

  it 'configures the global environment' do
    expect(chef_run).to execute_jenkins_script('configure global_env')
  end

  it 'notifies and sets the global_env_configured flag' do
    resource = chef_run.jenkins_script('configure global_env')
    expect(resource).to notify('ruby_block[set the global_env_configured flag]').to('create').immediately
  end

  it 'doesn\'t set the global_env_configured flag unless notified' do
    expect(chef_run).to_not run_ruby_block('set the global_env_configured flag')
  end
end
