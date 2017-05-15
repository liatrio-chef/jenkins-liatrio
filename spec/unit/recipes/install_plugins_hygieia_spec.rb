#
# ChefSpec for jenkins-liatrio
# Recipe: install_plugins_hygieia
# Author: Tyler Gering tyler@liatrio.com
#

require 'spec_helper'

describe 'jenkins-liatrio::install_plugins_hygieia' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    stub_command('java -jar /opt/jenkins-cli.jar -s http://localhost:8080/ list-plugins| grep hygieia-publisher').and_return(false)
  end

  it 'Creates Hygieia Publisher Cookbook File' do
    expect(chef_run).to create_cookbook_file('/var/lib/jenkins//hygieia-publisher.hpi').with(
      source: 'hygieia-publisher.hpi',
      mode: '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end

  it 'Installs Plugin Hygieia Publisher' do
    expect(chef_run).to run_execute('install-plugin-hygieia-publisher').with(
      command: 'java -jar /opt/jenkins-cli.jar -s http://localhost:8080/ install-plugin /var/lib/jenkins/hygieia-publisher.hpi'
    )
  end

  it 'Creates Hygieia Publisher Template' do
    expect(chef_run).to create_template('/var/lib/jenkins//jenkins.plugins.hygieia.HygieiaPublisher.xml').with(
      source:   'jenkins.plugins.hygieia.HygieiaPublisher.xml.erb',
      mode:     '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end
end
