FROM centos:centos7

MAINTAINER Robert Kelly "robert@liatrio.com"
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

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
RUN yum install -y \
      git && \
    yum clean all

# Copy the cookbook from the current working directory:
COPY . /tmp/jenkinscookbook
COPY docker-chef.json /

# Download and install the cookbook and its dependencies in the cookbook path:
RUN berks vendor -b /tmp/jenkinscookbook/Berksfile $COOKBOOK_PATH

# Run Chef Client, runs in local mode by default:
RUN chef-client -j docker-chef.json -r "recipe[yum-epel::default],recipe[jenkins-liatrio::default],recipe[jenkins-liatrio::install_plugins],recipe[jenkins-liatrio::plugin_maven],recipe[jenkins-liatrio::install_nodejs],recipe[jenkins-liatrio::git_settings]"

# Start Jenkins service The tail command prevents the command from quitting which previously stopped service
CMD service jenkins start && tail -F var/log/jenkins/error

EXPOSE 8080

# CMD to run you application
# Now you can create a Docker image and run your application:
# RUN docker build -t mycookbook .
# RUN docker run -d mycookbook bash
