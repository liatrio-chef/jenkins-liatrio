#
# ChefSpec for jenkins-liatrio
# Recipe: plugin_slack
# Author: Tyler Gering <tyler@liatrio.com>
#

# Currently this recipe doesn't have anything running in it.
require 'spec_helper'



describe 'jenkins-liatrio::plugin_slack' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(jenkins-liatrio::default,described_recipe) }

  before do
    Chef::EncryptedDataBagItem.stub(:load).with('jenkins', 'cred').and_return('slack_token' => 'slack_token',
                                                                              'slack_teamdomain' => 'slack_teamdomain',
                                                                              'slack_room' => 'slack_room',
                                                                              'slack_buildserver' => 'slack_buildserver')
  end

  it 'Creates  Slack Plugin Template' do
    expect(chef_run).to create_template('/var/lib/jenkins/jenkins.plugins.slack.SlackNotifier.xml').with(
      user: 'jenkins',
      group: 'jenkins',
      mode: '0644',
      source: 'jenkins.plugins.slack.SlackNotifier.xml.erb'
    )
  end

  it 'Restarts Jenkins' do
    resource = chef_run.template('/var/lib/jenkins/jenkins.plugins.slack.SlackNotifier.xml')
    expect(resource).to notify('jenkins').to('restart').delayed

  end

end
