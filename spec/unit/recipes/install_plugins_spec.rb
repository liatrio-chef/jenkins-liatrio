require 'spec_helper'

describe 'jenkins-liatrio::install_plugins' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  # provide before each it
  before do
    Chef::EncryptedDataBagItem.stub(:load).with('jenkins', 'cred').and_return('accesskey' => 'awsaccesskey',
                                                                              'secretkey' => 'awssecretkey',
                                                                              'admin_id_rsa' => 'long_private_key')
  end

  it 'installs jenkins_plugin `workflow-aggregator`' do
    expect(chef_run).to install_jenkins_plugin('workflow-aggregator')
  end

  it 'installs jenkins_plugin `maven-plugin`' do
    expect(chef_run).to install_jenkins_plugin('maven-plugin')
  end

  %w(workflow-aggregator job-dsl cloudbees-folder parameterized-trigger matrix-auth matrix-project github naginator sonar s3).each do |plugin|
    it "installs jenkins_plugin `#{plugin}`" do
      expect(chef_run).to install_jenkins_plugin(plugin.to_s)
    end
  end

  it 'creates template /var/lib/jenkins/hudson.tasks.Maven.xml' do
    expect(chef_run).to create_template('/var/lib/jenkins/hudson.tasks.Maven.xml')
  end

  it 'creates /var/lib/jenkins/admin_id_rsa with attributes' do
    expect(chef_run).to create_file('/var/lib/jenkins/admin_id_rsa').with(
      user:   'root',
      group:  'root',
      mode:  '0400',
      sensitive: true
    )
  end

  ### XXX fix this
  ##  it 'creates a /var/lib/jenkins/jenkins_crpyt.sh with attributes' do
  ##    expect(chef_run).to create_cookbook_file('/var/lib/jenkins/jenkins_crpyt.sh')
  ##  end

  ### XXX fix this
  ##  it 'runs a ruby_block generate_databasesecret_crypt_secretkey' do
  ##    expect(chef_run).to run_ruby_block('generate_databasesecret_crypt_secretkey')
  ##  end

  it 'creates template /var/lib/jenkins/hudson.plugins.s3.S3BucketPublisher.xml' do
    expect(chef_run).to create_template('/var/lib/jenkins/hudson.plugins.s3.S3BucketPublisher.xml')
  end
end
