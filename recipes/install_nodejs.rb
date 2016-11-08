#
# Cookbook Name:: jenkins-liatrio
# Recipe:: install_nodejs
#
# Author: Drew Holt <drew@liatrio.com>
#

# XXX make a requirement that epel recipe is required in the runlist
# install nodejs and npm
%w{nodejs npm}.each do |pkg|
  package pkg do
    action :install
  end
end
