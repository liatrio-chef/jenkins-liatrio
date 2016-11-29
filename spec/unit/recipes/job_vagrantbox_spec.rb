# Cookbook Name: jenkins-liatrio
# Spec::default
require 'spec_helper'

describe 'jenkins-liatrio::job_vagrantbox' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates template /var/lib/jenkins/jobs/petclinic-simple-config.xml' do
    expect(chef_run).to create_template(
      '/var/lib/jenkins/jobs/petclinic-simple-config.xml'
    ).with(
      source: 'jobs/petclinic-simple-config.xml.erb',
      mode: '0644',
      owner: 'jenkins',
      group: 'jenkins'
    )
  end

  it 'creates jenkins_job petclinic-simple' do
    expect(chef_run).to create_jenkins_job('petclinic-simple-auto-1').with(
      config: '/var/lib/jenkins/jobs/petclinic-simple-config.xml'
    )
  end

  it 'creates template /var/lib/jenkins/jobs/deploy-tomcat-config.xml' do
    expect(chef_run).to create_template(
        '/var/lib/jenkins/jobs/deploy-tomcat-config.xml'
      ).with(
        source: 'jobs/deploy-tomcat-config.xml.erb',
        mode: '0644',
        owner: 'jenkins',
        group: 'jenkins'
      )
  end

  it 'creates jenkins_job deploy-tomcat' do
    expect(chef_run).to create_jenkins_job('deploy-tomcat').with(
      config: '/var/lib/jenkins/jobs/deploy-tomcat-config.xml'
    )
  end

  it 'creates template selenium-chrome-petclinic-test-config.xml' do
    expect(chef_run).to create_template(
        '/var/lib/jenkins/jobs/selenium-chrome-petclinic-test-config.xml'
      ).with(
        source: 'jobs/selenium-chrome-petclinic-test-config.xml.erb',
        mode: '0644',
        owner: 'jenkins',
        group: 'jenkins'
      )
  end

  it 'creates jenkins_job selenium-chrome-petclinic-test' do
    expect(chef_run).to create_jenkins_job(
      'selenium-chrome-petclinic-test'
    ).with(
      config: '/var/lib/jenkins/jobs/selenium-chrome-petclinic-test-config.xml'
    )
  end

  it 'creates template selenium-firefox-petclinic-test-config.xml' do
    expect(chef_run).to create_template(
        '/var/lib/jenkins/jobs/selenium-firefox-petclinic-test-config.xml'
      ).with(
        source: 'jobs/selenium-firefox-petclinic-test-config.xml.erb',
        mode: '0644',
        owner: 'jenkins',
        group: 'jenkins'
      )
  end

  it 'creates jenkins_job selenium-firefox-petclinic-test' do
    expect(chef_run).to create_jenkins_job(
      'selenium-firefox-petclinic-test'
    ).with(
      config: '/var/lib/jenkins/jobs/selenium-firefox-petclinic-test-config.xml'
    )
  end
end
