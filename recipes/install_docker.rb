#
# Cookbook Name:: jenkins-liatrio
# Recipe::install_docker
#
# Author: Justin Bankes <justin@liatrio.com
#
docker_installation 'default' do
  action :create
end

group 'docker' do
  action :modify
  members 'jenkins'
  append true
  notifies :run, 'bash[post-docker]', :immediately
end

service 'docker' do
  action :enable
end

bash 'post-docker' do
  action :nothing
  code <<-EOH
    usermod -aG docker jenkins
    systemctl daemon-reload
    systemctl restart docker
    service jenkins restart
  EOH
end
