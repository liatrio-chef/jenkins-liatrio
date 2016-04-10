jenkins-liatrio Cookbook
========================
A wrapper cookbook that installs jenkins to be used with archiva-liatrio, sonarqube-liatrio, tomcat-liatrio, and hygieia-liatrio in a pipeline.

Requirements
------------
Berkshelf

Vagrant 1.9.1

Usage
-----
#### jenkins-liatrio::default

`vagrant up`

or 

Just include `jenkins-liatrio` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jenkins-liatrio]"
    "recipe[jenkins-liatrio::install_plugins]"
    "recipe[jenkins-liatrio::create_job]"
    "recipe[jenkins-liatrio::create_creds]"
  ]
}
```

Attributes
----------
```
default[:jenkins_liatrio][:create_job][:maven_goals] = 'clean install'
default[:jenkins_liatrio][:nexus_repo] = 'nexus.local'
default[:jenkins_liatrio][:packages]              = %w{java-1.8.0-openjdk-devel java-1.8.0-openjdk maven maven-war-plugin}
default[:jenkins_liatrio][:sleep_interval_small]  = 3
default[:jenkins_liatrio][:install_plugins][:plugins_list]  = %w{git github naginator sonar}
default[:jenkins_liatrio][:install_plugins][:enablearchiva]	= false
default[:jenkins_liatrio][:install_plugins][:maven_mirror]	= "http://localhost:8081/repository/internal"
default[:jenkins_liatrio][:install_plugins][:enablesonar]		= false
default[:jenkins_liatrio][:install_plugins][:enablearchiva]		= false
default[:jenkins_liatrio][:install_plugins][:sonarurl]		  = "http://localhost:9000"
default[:jenkins_liatrio][:install_plugins][:sonarjdbcurl]	= "tcp://localhost:9092/sonar"
default[:jenkins_liatrio][:install_plugins][:jenkinsdlurl]	= "http://pkg.jenkins-ci.org/redhat/jenkins-1.653-1.1.noarch.rpm"
default[:jenkins_liatrio][:install_plugins][:githuburl]     = "https://github.com/drewliatro/spring-petclinic/"
default[:jenkins_liatrio][:install_plugins][:giturl]		    = "https://github.com/drew-liatrio/spring-petclinic.git"
default[:jenkins_liatrio][:install_plugins][:hygieia_url]   = "http://192.168.100.10:8080/api/"
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Drew Holt <drew@liatrio.com>
