#
# ChefSpec for jenkins-liatrio
# Recipe: swapfile
# Author: Tyler Gering tyler@liatrio.com
#

require 'spec_helper'

describe 'jenkins-liatrio::swapfile' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }



  it 'Creates Swapfile' do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('/var/swapfile').and_return(false)
    expect(chef_run).to run_bash('create_swapfile')
  end

  it 'Enables Mount' do
    expect(chef_run).to enable_mount('/dev/null')
  end

  it 'Activates Swap' do
    expect(chef_run).to run_bash('activate_swap')
  end
end
