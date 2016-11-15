name             'jenkins-liatrio'
maintainer       'Liatrio'
maintainer_email 'drew@liatrio.com'
license          'All rights reserved'
description      'Installs/Configures jenkins-liatrio'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'

depends 'jenkins', '~> 2.6.0'
depends "apache2", "~> 3.2.2"
