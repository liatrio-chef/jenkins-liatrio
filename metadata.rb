name             'jenkins-liatrio'
maintainer       'Liatrio'
maintainer_email 'drew@liatrio.com'
license          'All rights reserved'
description      'Installs/Configures jenkins-liatrio'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.4.3'

depends 'swap', '~> 0.3.8'
depends 'java', '~> 1.42.0'
depends 'jenkins', '~> 2.6.0'
depends 'apache2', '~> 3.2.2'
depends 'yum-epel', '~> 2.0.0'
