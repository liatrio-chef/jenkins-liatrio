# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

Vagrant.require_version '1.8.4'

[
  { name: 'vagrant-berkshelf', version: '>= 5.0.0' }
].each do |plugin|
  unless Vagrant.has_plugin?(plugin[:name], plugin[:version])
    raise "#{plugin[:name]} #{plugin[:version]} is required. " \
          "Please run `vagrant plugin install #{plugin[:name]}`"
  end
end

# Execute these shell commands outside of Bundler environment
Bundler.with_clean_env do
  # Require ChefDK version 0.16.28
  chefdkversion = `chef -v 2>/dev/null | head -n 1 | awk -F' ' '{print $5}' | tr -d '\n'`
  unless chefdkversion.eql?'0.16.28'
    raise "Chef Development Kit Version 0.16.28 is required.\n" \
          'Please change to version 0.16.28.'
  end
  # Require VirtualBox version 5.0.26
  virtualboxversion = `vboxmanage --version | awk -F'r' '{print $1}' | tr -d '\n'`
  unless virtualboxversion.eql?'5.0.26'
    raise "VirtualBox Version 5.0.26 is required.\n" \
          'Please change to version 5.0.26.'
  end
end

Vagrant.configure(2) do |config|
  config.vm.box = 'bento/centos-7.2'

  config.berkshelf.enabled = true
  config.vm.provision 'chef_solo' do |chef|
    chef.version = '12.16.42'

    # path to data bag secret file
    chef.encrypted_data_bag_secret_key_path =
      './encrypted_data_bag_secret_vagrant'

    # path to data_bags directory relative to cwd
    chef.data_bags_path = 'data_bags/'

    # Add chef recipes from chef-config
    chef_config = YAML.load_file('./.kitchen.local.yml')
    puts chef_config
    chef_config['suites'][0]['run_list'].each do |recipe_string|
      # Extract recipe from the recipe_string
      recipe = recipe_string.split(/\[|\]/)[1]
      chef.add_recipe recipe
    end

    chef.json = {
      'java' => {
        'jdk_version' => '8',
        'install_flavor' => 'openjdk'
      },
      'jenkins' => {
        'master' => {
          'version' => '2.49-1.1',
          'jvm_options' => '-Djenkins.install.runSetupWizard=false',
          'host' => 'localhost',
          'port' => 8080,
          # "repostiroy" => "http://mirrors.jenkins-ci.org/redhat/"
        }
      },
      'jenkins_liatrio' => {
        'install_plugins' => {
          # 'plugins_list' => %w(git github naginator sonar),
          # 'enablearchiva' => false,
          # 'maven_mirror' => 'http://localhost:8081/repository/internal',
          # 'enablesonar' => false,
          # 'sonarurl' => 'http://192.168.1.10:9000',
          # 'sonarjdbcurl' => 'tcp://localhost:9092/sonar',
          'githuburl' => 'https://github.com/drewliatro/spring-petclinic/',
          'giturl' => 'https://github.com/drew-liatrio/spring-petclinic.git',
          # 'hygieiaurl' => 'http://192.168.100.10:8080/api/'
        },
        'create_job' => {
          'maven_goals' => 'clean install'
        }
      }
    }
  end

  config.vm.network :private_network, ip: '192.168.100.20'
  config.vm.network 'forwarded_port', guest: 8080, host: 18080

  config.vm.provider :virtualbox do |v|
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.customize ['modifyvm', :id, '--cableconnected1', 'on']
    v.customize ['modifyvm', :id, '--cableconnected2', 'on']
  end

  # config.vm.provision 'shell', inline: 'systemctl stop firewalld'
end
