require 'spec_helper'

describe 'jenkins-liatrio::install_plugins' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  # provide before each it
  before do
    Chef::EncryptedDataBagItem.stub(:load).with('jenkins', 'cred').and_return('accesskey' => 'awsaccesskey',
                                                                              'secretkey' => 'awssecretkey',
                                                                              'admin_id_rsa' => 'long_private_key')
  end

  #  %w(workflow-aggregator job-dsl cloudbees-folder parameterized-trigger matrix-auth matrix-project github naginator sonar s3).each do |plugin|
  #    it "installs jenkins_plugin `#{plugin}`" do
  #      expect(chef_run).to install_jenkins_plugin(plugin.to_s)
  #    end
  #  end
end
