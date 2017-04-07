#
# Cookbook::jenkins-liatrio
# Recipe::install_docker
#
require 'spec_helper'

describe 'jenkins-liatrio::install_docker' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs docker' do
    expect(chef_run).to create_docker_installation('default')
  end

  it 'adds jenkins user to docker group' do
    expect(chef_run).to modify_group('docker').with(
      members: ['jenkins'],
      append: true
    )
  end

  it 'notifies post docker shell' do
    resource = chef_run.group('docker')
    expect(resource).to notify('bash[post-docker]').to('run').immediately
  end

  it 'enables docker service to run on startup' do
    expect(chef_run).to enable_service('docker')
  end

  it 'sets up jenkins docker groups' do
    expect(chef_run).to_not run_bash('post-docker')
  end
end
