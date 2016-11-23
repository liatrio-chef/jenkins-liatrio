#
# Cookbook Name:: jenkins-liatrio
# Recipe:: credential_chefuploader
#
# Author: Drew Holt <drew@liatrio.com>
#

# load encrypted data bag
# jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')

# XXX LTA-125
# jenkins_private_key_credentials 'CHEFUPLOADER' do
#  id 'bf42b6f2-54ab-4172-a24c-48b2bec6737f'
#  description 'Chef cookbook uploader pem file'
#  private_key jenk_databag['chefuploader']
# end
