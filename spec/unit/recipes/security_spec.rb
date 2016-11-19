require "spec_helper"

describe "jenkins-liatrio::security" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  # provide before each it
  before do
    Chef::EncryptedDataBagItem.stub(:load).with("jenkins", "cred").and_return("admin_id_rsa" => "private",
                                                                              "admin_id_rsa_pub" => "public",
                                                                              "admin_password" => "password")
  end

  # XXX fix this
  #  it 'runs set_jenkins_private_key ruby_block with the default action' do
  #    expect(chef_run).to run_ruby_block('set_jenkins_private_key')
  #  end

  it "creates jenkins_user admin" do
    expect(chef_run).to create_jenkins_user("admin")
  end

  it "runs jenkins_script `configure_permissions`" do
    expect(chef_run).not_to execute_jenkins_script("configure_permissions")
  end

  # XXX fix this
  #  it 'runs ruby_block `set the security_enabled flag` with the default action' do
  #    expect(chef_run).to run_ruby_block('set the security_enabled flag')
  #  end
end
