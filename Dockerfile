FROM centos:7
MAINTAINER Xabier de Zuazo "xabier@zuazo.org"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/chef/bin:/opt/chef/embedded/bin \
    LANG=en_US.UTF-8 \
    CHEF_REPO_PATH=/tmp/chef
ENV COOKBOOK_PATH=$CHEF_REPO_PATH/cookbooks

# Install chef-client
RUN curl -L --progress-bar https://www.chef.io/chef/install.sh | bash -s -- -P chefdk

# Configure Chef Client
RUN mkdir -p $COOKBOOK_PATH && \
    mkdir -p /etc/chef ~/.chef && \
    echo "cookbook_path %w($COOKBOOK_PATH)" > /etc/chef/client.rb && \
    echo "local_mode true" >> /etc/chef/client.rb && \
    echo "chef_zero.enabled true" >> /etc/chef/client.rb && \
    ln /etc/chef/client.rb ~/.chef/config.rb

# Some optional but recommended packages
#RUN yum install -y \
#      git && \
#    yum clean all

CMD ["bash"]

#FROM zuazo/chef-local:centos-7

# Copy the cookbook from the current working directory:
COPY . /tmp/jenkinscookbook
# Download and install the cookbook and its dependencies in the cookbook path:
 RUN berks vendor -b /tmp/jenkinscookbook/Berksfile $COOKBOOK_PATH
# Run Chef Client, runs in local mode by default:
 RUN chef-client -r "recipe[apt],recipe[jenkinscookbook]"
 RUN chef-client -r "recipe[yum-epel::default],recipe[jenkins-liatrio::default],recipe[jenkins-liatrio::plugin_maven]"

# CMD to run you application
# Now you can create a Docker image and run your application:
 RUN docker build -t mycookbook .
 RUN docker run -d mycookbook bash
