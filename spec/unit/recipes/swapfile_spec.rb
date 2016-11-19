require 'spec_helper'

describe 'jenkins-liatrio::swapfile' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'runs create_swapfile bash script with the default action' do
    expect(chef_run).to run_bash('create_swapfile')
  end

  it 'mounts adds /var/swapfile to fstab (dummy mount for /dev/null)' do
    expect(chef_run).to enable_mount('/dev/null')
  end

  it 'runs activate_swap bash script with the default action' do
    expect(chef_run).to run_bash('activate_swap')
  end
end
