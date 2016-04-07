# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "liatrio/centos7chefjava"

  config.berkshelf.enabled = true
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "jenkins-liatrio::default"
    chef.add_recipe "jenkins-liatrio::install_plugins"
    chef.add_recipe "jenkins-liatrio::create_job"
    chef.add_recipe "minitest-handler"
    chef.json = {
        "jenkins_liatrio" => {
          "maven_mirror" => "http://localhost:8081/repository/internal",
          "sonarurl" => "http://192.168.1.10:9000",
          "sonarjdbcurl" => "tcp://localhost:9092/sonar",
          "githuburl" => "https://github.com/drewliatro/spring-petclinic/",
          "giturl" => "https://github.com/drew-liatrio/spring-petclinic.git",
          "ip" => "localhost",
          "port" => "8080",
          #"jenkinsdlurl" => "http://192.168.1.125/jenkins-1.653-1.1.noarch.rpm",
          "hygieiaurl" => "http://192.168.100.10:8080/api/"
        }
    }
  end

  config.vm.network :private_network, ip: "192.168.100.20"
  config.vm.network "forwarded_port", guest: 8080, host: 18080

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision "shell", inline: "firewall-cmd --permanent --add-port=8080/tcp && firewall-cmd --reload"

end
