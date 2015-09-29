default['ruby']['ruby_build']['install_path'] = '/opt/ruby-build'
default['ruby']['ruby_build']['git_url'] = 'git://github.com/sstephenson/ruby-build.git'
default['ruby']['ruby_build']['git_ref'] = 'master'
default['ruby']['ruby_build']['install_pkgs'] =  %w(build-essential bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev ssl-cert subversion git-core libffi-dev)
default['ruby']['ruby_build']['tmp_dir_path'] = '/tmp'
