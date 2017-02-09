#
# ChefSpec for jenkins-liatrio
# Recipe: git_settings
# Author: Tyler Gering <tyler@liatrio.com>
#

# Currently this recipe doesn't have anything running in it.
require 'spec_helper'

describe 'jenkins-liatrio::git_settings' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  it 'Creates git configurations template' do
    expect(chef_run).to create_template('/var/lib/jenkins/.gitconfig').with(
      user: 'jenkins',
      group: 'jenkins',
      mode: '0644',
      source: '.gitconfig.erb'
    )
  end
end
