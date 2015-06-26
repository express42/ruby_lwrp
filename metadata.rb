name             'ruby_lwrp'
maintainer       'LLC Express 42'
maintainer_email 'cookbooks@express42.com'
license          'MIT'
description      'Installs chruby and ruby-build to build rubies from source'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.7'

recipe           'ruby_lwrp::default', 'Includes `ruby_build` and `chruby` recipes.'
recipe           'ruby_lwrp::chruby', 'Installs the Chruby to `/opt/chruby` and prepares Chef to `ruby_set` the LWRP.'
recipe           'ruby_lwrp::ruby_build', 'Installs the ruby-build to `/opt/ruby-build` and prepares Chef to use `ruby_install` LWRP.'

supports         'debian'
supports         'ubuntu'
