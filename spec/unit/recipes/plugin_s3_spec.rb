#
# ChefSpec for jenkins-liatrio
# Recipe: plugin_s3
# Author: Tyler Gering tyler@liatrio.com
#

# Currently this recipe doesn't have anything running in it.
require 'spec_helper'

describe 'jenkins-liatrio::plugin_s3' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge('jenkins-liatrio::default',described_recipe) }

  before do
    Chef::EncryptedDataBagItem.stub(:load).with('jenkins', 'cred').and_return(
      'secretkey' => 'secret',
      'accesskey' => 'access'
    )
  end

  it 'Includes Security Recipe' do
    expect(chef_run).to include_recipe('jenkins-liatrio::security')
  end

  it 'Generates Databasesecret Crypt Secretkey' do
    expect(chef_run).to run_ruby_block('generate_databasesecret_crypt_secretkey')
  end

  it 'Creates S3 Template' do
    expect(chef_run).to create_template('/var/lib/jenkins/hudson.plugins.s3.S3BucketPublisher.xml').with(
      source:   'hudson.plugins.s3.S3BucketPublisher.xml.erb',
      mode:     '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end

  it 'Notifies Restart of Jenkins Service' do
    template = chef_run.template('/var/lib/jenkins/hudson.plugins.s3.S3BucketPublisher.xml')
    expect(template).to notify('service[jenkins]').to(:restart).delayed
  end


end
