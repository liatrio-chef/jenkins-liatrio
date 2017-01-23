#
# ChefSpec for jenkins-liatrio
# Recipe: configure_mail
# Author: Justin Bankes justin@liatrio.com
#

# Currently this recipe doesn't have anything running in it.
require 'spec_helper'

describe 'jenkins-liatrio::credential_chefuploader' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
end
