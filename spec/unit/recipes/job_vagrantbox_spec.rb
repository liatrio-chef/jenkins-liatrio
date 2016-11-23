require 'spec_helper'

describe 'jenkins-liatrio::job_vagrantbox' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates template /var/lib/jenkins/jobs/petclinic-simple-config.xml' do
    expect(chef_run).to create_template('/var/lib/jenkins/jobs/petclinic-simple-config.xml').with(
      source: 'jobs/petclinic-simple-config.xml.erb',
      mode: '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end

  it 'creates jenkins_job petclinic-simple' do
    expect(chef_run).to create_jenkins_job('petclinic-simple-auto-1')
  end
end
