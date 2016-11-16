#
# Cookbook Name: jenkins-liatrio
# Spec::default
require 'spec_helper'

describe 'jenkins-liatrio::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.2.1511'
    ).converge(described_recipe)
  end

  it 'includes jenkins::master recipe' do
    expect(chef_run).to include_recipe('jenkins::master')
  end

  it 'creates jenkins\' .m2 directory' do
    expect(chef_run).to create_directory('/var/lib/jenkins/.m2').with(
      mode: '0755'
    )
  end

  it 'places the settings.xml file in \'etc/maven/\'' do
    expect(chef_run).to create_template('/etc/maven/settings.xml').with(
      source: 'etc/maven/settings.xml.erb',
      mode: '0755'
    )
  end
end
