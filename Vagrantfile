# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'bento/centos-7.2'

  config.berkshelf.enabled = true
  config.vm.provision 'chef_solo' do |chef|
    # path to data bag secret file
    chef.encrypted_data_bag_secret_key_path =
      './encrypted_data_bag_secret_vagrant'

    # path to data_bags directory relative to cwd
    chef.data_bags_path = 'data_bags/'

    chef.add_recipe 'jenkins-liatrio::default'
    chef.add_recipe 'jenkins-liatrio::install_plugins'
    chef.add_recipe 'jenkins-liatrio::plugin_maven'
    chef.add_recipe 'jenkins-liatrio::plugin_sonar'
    chef.add_recipe 'jenkins-liatrio::configure_mail'
    # chef.add_recipe "jenkins-liatrio::plugin_hygieia"
    chef.add_recipe 'jenkins-liatrio::m2_settings'
    chef.add_recipe 'jenkins-liatrio::security'
    chef.add_recipe 'jenkins-liatrio::job_vagrantbox'

    chef.json = {
      'java' => {
        'jdk_version' => '8',
        'install_flavor' => 'openjdk'
      },
      'jenkins' => {
        'master' => {
          'version' => '2.28-1.1',
          'jvm_options' => '-Djenkins.install.runSetupWizard=false',
          'host' => 'localhost',
          'port' => 8080,
          # "repostiroy" => "http://mirrors.jenkins-ci.org/redhat/"
        }
      },
      'jenkins_liatrio' => {
        'install_plugins' => {
          # 'plugins_list' => %w(git github naginator sonar),
          'enablearchiva' => false,
          'maven_mirror' => 'http://localhost:8081/repository/internal',
          'enablesonar' => false,
          'sonarurl' => 'http://192.168.1.10:9000',
          'sonarjdbcurl' => 'tcp://localhost:9092/sonar',
          'githuburl' => 'https://github.com/drewliatro/spring-petclinic/',
          'giturl' => 'https://github.com/drew-liatrio/spring-petclinic.git',
          'hygieiaurl' => 'http://192.168.100.10:8080/api/'
        },
        'create_job' => {
          'maven_goals' => 'clean install'
        }
      }
    }
  end

  config.vm.network :private_network, ip: '192.168.100.20'
  config.vm.network 'forwarded_port', guest: 8080, host: 18_080

  config.vm.provider :virtualbox do |v|
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end

  config.vm.provision 'shell', inline: 'systemctl stop firewalld'
end
