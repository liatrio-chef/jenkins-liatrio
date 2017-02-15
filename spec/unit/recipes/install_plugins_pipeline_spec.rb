#
# ChefSpec for jenkins-liatrio
# Recipe: install_plugins_pipeline
# Author: Tyler Gering tyler@liatrio.com
#

# Currently this recipe doesn't have anything running in it.
require 'spec_helper'

describe 'jenkins-liatrio::install_plugins_pipeline' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    stub_command('cd /var/lib/jenkins; unzip sonar-runner-dist-2.4.zip').and_return(true)
    stub_command('/var/lib/jenkins/sonar-runner-2.4').and_return(false) # this might need to change
  end

  it 'Creates Sonar-Runner Cookbook_file' do
    expect(chef_run).to create_cookbook_file('/var/lib/jenkins/sonar-runner-dist-2.4.zip').with(
      source: 'sonar-runner-dist-2.4.zip',
      owner: 'jenkins',
      group: 'jenkins',
      mode: '0644'
    )
  end

  it 'Unzips Sonar Runner' do
    expect(chef_run).to run_execute('unzip_sonar-runner')
  end

  it 'Creates Sonar Publisher Template' do
    expect(chef_run).to create_template('/var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml').with(
      source:   'hudson.plugins.sonar.SonarPublisher.xml.erb',
      mode:     '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end

  it 'Creates Sonar-Runner Install Template' do
    expect(chef_run).to create_template('/var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml').with(
      source:  'hudson.plugins.sonar.SonarRunnerInstallation.xml.erb',
      mode:  '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end

  it 'Creates Sonar Runner Properties Templates' do
    expect(chef_run).to create_template('/var/lib/jenkins//sonar-runner-2.4/conf/sonar-runner.properties').with(
      source:   'sonar-runner-2.4/conf/sonar-runner.properties.erb',
      mode:     '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end
end
