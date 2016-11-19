require "spec_helper"

describe "jenkins-theia::apache2" do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  # provide before each it
  before do
    Chef::EncryptedDataBagItem.stub(:load).with("jenkins", "cred").and_return("site_fqdn" => "somesite.liatrio.com",
                                                                              "sslkey" => "secret")

    stub_command("/usr/sbin/httpd -t").and_return(true)
  end

  # include recipes
  %w{apache2 apache2::mod_proxy apache2::mod_proxy_http apache2::mod_proxy_ajp apache2::mod_ssl}.each do |recipe|
    it "includes the #{recipe} recipe" do
      expect(chef_run).to include_recipe(recipe.to_s)
    end
  end

  it "creates /etc/httpd/ssl with the default action" do
    expect(chef_run).to create_remote_directory("/etc/httpd/ssl")
  end

  it "creates /etc/httpd/ssl/somesite.liatrio.com with attributes" do
    expect(chef_run).to create_file("/etc/httpd/ssl/somesite.liatrio.com.key").with(
      user:   "root",
      group:  "root",
      mode:  0o400,
      sensitive: true
    )
  end

  it "creates template /etc/httpd/conf-enabled/ssl.conf" do
    expect(chef_run).to create_template("/etc/httpd/conf-enabled/ssl.conf")
  end
end
