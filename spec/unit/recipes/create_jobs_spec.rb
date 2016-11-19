require "spec_helper"

describe "jenkins-liatrio::create_jobs" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it "creates template /var/lib/jenkins/jobs/AutomationManagementJob-config.xml" do
    expect(chef_run).to create_template("/var/lib/jenkins/jobs/AutomationManagementJob-config.xml").with(
      source: "jobs/AutomationManagementJob-config.xml.erb",
      mode: "0644",
      owner: "jenkins",
      group: "jenkins"
    )
  end

  it "creates jenkins_job AutomationManagementJob" do
    expect(chef_run).to create_jenkins_job("AutomationManagementJob")
  end
end
