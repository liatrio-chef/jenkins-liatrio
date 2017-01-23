#
# ChefSpec for jenkins-liatrio
# Recipe: configure_mail
# Author: Justin Bankes justin@liatrio.com
#
require 'spec_helper'

describe 'jenkins-liatrio::configure_mail' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('jenkins', 'cred').and_return(
      'email_address' => 'none@none.com'
    )
  end

  it 'configures mail with a jenkins script' do
    expect(chef_run).to execute_jenkins_script('configure mail')
  end

  it 'notifies and sets the mail_configured flag' do
    resource = chef_run.jenkins_script('configure mail')
    expect(resource).to notify('ruby_block[set the mail_configured flag]').to('create').immediately
  end

  it 'doesn\'t set the mail_configured flag unless notified' do
    expect(chef_run).to_not run_ruby_block('set the mail_configured flag')
  end
end
