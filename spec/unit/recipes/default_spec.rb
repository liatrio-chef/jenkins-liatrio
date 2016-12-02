require 'spec_helper'

describe 'jenkins-liatrio::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  packages = %w(java-1.8.0-openjdk-devel java-1.8.0-openjdk git wget unzip bzip2)
  packages.each do |pkg|
    it "installs package #{pkg}" do
      expect(chef_run).to install_package(pkg)
    end
  end

  it 'creates a swapfile' do
    expect(chef_run).to create_swap_file('/etc/swapfile').with(
      size: 4096
    )
  end

  it 'runs ruby_block `before_wait_for_jenkins`' do
    expect(chef_run).to run_ruby_block('before_wait_for_jenkins')
  end
end
