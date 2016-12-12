# Cookbook Name: jenkins-liatrio
# Spec::default
require 'spec_helper'

describe 'jenkins-liatrio::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes java default recipe' do
    expect(chef_run).to include_recipe('java::default')
  end

  it 'includes yum-epel default recipe' do
    expect(chef_run).to include_recipe('yum-epel::default')
  end

  packages = %w(
    java-1.8.0-openjdk-devel
    java-1.8.0-openjdk
    git
    wget
    unzip
    bzip2
  )
  packages.each do |pkg|
    it "installs package #{pkg}" do
      expect(chef_run).to install_package(pkg)
    end
  end

  it 'creates a swapfile' do
    expect(chef_run).to create_swap_file('/var/swapfile').with(
      size: 4096
    )
  end

  it 'runs ruby_block `before_wait_for_jenkins`' do
    expect(chef_run).to run_ruby_block('before_wait_for_jenkins')
  end

  it 'creates the remote file jenkins-cli.jar if it is missing' do
    expect(chef_run).to create_remote_file_if_missing('/opt/jenkins-cli.jar')
  end

  # need to test not_if here
end
