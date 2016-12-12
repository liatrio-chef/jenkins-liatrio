#
# Cookbook Name:: jenkins-liatrio
# Recipe:: swapfile
#
# Author: Drew Holt <drew@liatrio.com>
#

# adapted from http://www.opinionatedprogrammer.com/2011/07/creating-a-swap-file-with-chef/

# create a 4GB swapfile
bash 'create_swapfile' do
  action :run
  code 'dd if=/dev/zero of=/var/swapfile bs=1M count=4096 && chmod 600 /var/swapfile && mkswap /var/swapfile'
  not_if { File.exist?('/var/swapfile') }
end

# loop back swap file entry to add to /etc/fstab
mount '/dev/null' do
  action :enable # cannot mount; only add to fstab
  device '/var/swapfile'
  fstype 'swap'
end

# mount all swaps in /etc/fstab
bash 'activate_swap' do
  action :run
  code 'swapon -a'
end
