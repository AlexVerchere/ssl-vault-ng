name             'ssl-vault-ng'
maintainer       'Jean-Baptiste Raffin'
maintainer_email 'raffin_j@laposte.net'
license          'The MIT License (MIT)'
description      'SSL key & certificate storage in chef-vault.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version "1.2.1"
supports 'ubuntu'
depends 'chef-vault'
