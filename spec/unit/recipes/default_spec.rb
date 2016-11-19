require "spec_helper"

describe "jenkins-theia::default" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  packages = %w{java-1.8.0-openjdk-devel java-1.8.0-openjdk maven maven-war-plugin git wget bzip2 groovy epel-release}
  packages.each do |pkg|
    it "installs package #{pkg}" do
      expect(chef_run).to install_package(pkg)
    end
  end

  it "installs nodejs" do
    expect(chef_run).to install_package("nodejs")
  end

  it "installs npm" do
    expect(chef_run).to install_package("npm")
  end

  it "runs ruby_block before_wait_for_jenkins" do
    expect(chef_run).to run_ruby_block("before_wait_for_jenkins")
  end

  it "runs execute get_jenkins_cli_jar" do
    expect(chef_run).to run_execute("get_jenkins_cli_jar")
  end

  it "creates template /var/lib/jenkins/config.xml" do
    expect(chef_run).to create_template("/var/lib/jenkins/config.xml")
  end
end
