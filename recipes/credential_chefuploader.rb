#
# Cookbook Name:: jenkins-liatrio
# Recipe:: credential_chefuploader
#
# Author: Drew Holt <drew@liatrio.com>
#

# load encrypted data bag
jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')

jenkins_secret_text_credentials 'CHEFUPLOADER' do
  id          'CHEFUPLOADER'
  description 'Chef cookbook uploader pem file'
  secret      jenk_databag['chefuploader']
end
