jenkins-liatrio CHANGELOG
=========================

This file is used to list changes made in each version of the jenkins-liatrio cookbook.

1.5.0
-----
- Ticket: CHICO-302 by Justin Bankes
- Added Blue Ocean and dependencies to plugins. 
- Added Google-Login to plugins. 

1.4.5 
-----
- Ticket: LTA-148 by Justin Bankes
- Added initscipts install in .kitchen.yml

1.4.4 
-----
- Ticket: LTA 135 by Justin Bankes
- Added Spec tests for:
  - default recipe
  - apache2 recipe
  - job_vagrantbox recipe

1.1.2 - 12.02.2016
-----
- Ticket: LTA-138 by Justin Bankes
- Removed Swapfile recipe 
- Implemented Swap file from swap 


1.1.1 - 11.15.2016
-----
- Ticket: LTA-95 by Justin Bankes
  - Updated Vagrantfile to use bento/centos box.
  - Added java to the runlist in the vagrantfile
  - Added install _unzip_ via yum_package resource.
  - Ran Rubocop linter with -a flag

1.1.0 - 11.15.2016
-----
- Ticket: LTA-89 by Justin Bankes
  - Added Recipe for Slack plugin for jenkins
  - Added Template for Slack config
  - Fixed Vagrantfile to turn off firwall for local testing.


0.1.0
-----
- Drew Holt - Initial release of jenkins-liatrio

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
