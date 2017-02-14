#
# ChefSpec for jenkins-liatrio
# Recipe: plugin_hygieia
# Author: Tyler Gering tyler@liatrio.com
#

require 'spec_helper'

describe 'jenkins-liatrio::plugin_hygieia' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    stub_command('java -jar /opt/jenkins-cli.jar -s http://build.liatrio.com:8080/ install-plugin /var/lib/jenkins/hygieia-publisher.hpi').and_return(true)
    stub_command('java -jar /opt/jenkins-cli.jar -s http://localhost:8080/ list-plugins| grep hygieia-publisher').and_return(false)
  end

  it 'Creates Cookbook File' do
    expect(chef_run).to create_cookbook_file('/var/lib/jenkins/hygieia-publisher.hpi').with(
      source: 'hygieia-publisher.hpi',
      mode: '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end

  it 'Installs Plugin HygeiaPublisher' do
    expect(chef_run).to run_execute('install-plugin-hygieia-publisher')
  end

  it 'Creates HygeiaPublisher Template' do
    expect(chef_run).to create_template('/var/lib/jenkins/jenkins.plugins.hygieia.HygieiaPublisher.xml').with(
      source:   'jenkins.plugins.hygieia.HygieiaPublisher.xml.erb',
      mode:     '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end
end
