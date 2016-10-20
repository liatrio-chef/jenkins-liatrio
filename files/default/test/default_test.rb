require 'minitest/spec'

def service_is_listening(port, service)
  assert system "sudo netstat -lp --numeric-ports | grep \":#{port}.*LISTEN.*#{service}\""
end

def web_check_match(url, check)
  assert system "wget -q -O - #{url} | grep '#{check}'"
end

describe_recipe 'jenkins-liatrio::default' do
  # use port attribute for this
  #  it "listens for http on tcp port 8080" do
  #    service_is_listening("8080", "java")
  #  end

  # it 'must match the web check Apache' do
  #  web_check_match("http://127.0.0.1/", "Apache")
  # end

  # it should test for each plugin attribute that it is installed

  # it should test that each job was created
end
