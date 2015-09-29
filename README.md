# Description

[![Cookbook Version](http://img.shields.io/cookbook/v/ruby_lwrp.svg)]('http://img.shields.io/cookbook/v/ruby\_lwrp.svg)
[![Code Climate](https://codeclimate.com/github/express42-cookbooks/ruby_lwrp/badges/gpa.svg)](https://codeclimate.com/github/express42-cookbooks/ruby_lwrp)
[![Build Status](https://travis-ci.org/express42-cookbooks/ruby_lwrp.svg?branch=master)](https://travis-ci.org/express42-cookbooks/ruby_lwrp)

Cookbook `ruby_lwrp` builds various versions of ruby and installs them to `/opt/rubies`. It uses [ruby-build](https://github.com/sstephenson/ruby-build) to build and install ruby and [chruby](https://github.com/postmodern/chruby) for switching between installed ruby versions.

# Requirements

## Platform:

* Debian
* Ubuntu

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['ruby']['chruby']['install_path']` -  Defaults to `"/opt/chruby"`.
* `node['ruby']['chruby']['home_prefix']` -  Defaults to `"/home"`.
* `node['ruby']['chruby']['git_url']` -  Defaults to `"git://github.com/postmodern/chruby.git"`.
* `node['ruby']['chruby']['git_ref']` -  Defaults to `"master"`.
* `node['ruby']['chruby']['install_pkgs']` -  Defaults to `"%w(make git-core)"`.
* `node['ruby']['ruby_build']['install_path']` -  Defaults to `"/opt/ruby-build"`.
* `node['ruby']['ruby_build']['git_url']` -  Defaults to `"git://github.com/sstephenson/ruby-build.git"`.
* `node['ruby']['ruby_build']['git_ref']` -  Defaults to `"master"`.
* `node['ruby']['ruby_build']['install_pkgs']` -  Defaults to `"%w(build-essential bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev ssl-cert subversion git-core libffi-dev)"`.
* `node['ruby']['ruby_build']['tmp_dir_path']` - Defaults to '"/tmp"'. It sets TMPDIR for ruby-build.

# Recipes

* ruby_lwrp::default - Includes `ruby_build` and `chruby` recipes.
* ruby_lwrp::chruby - Installs the Chruby to `/opt/chruby` and prepares Chef to `ruby_set` the LWRP.
* ruby_lwrp::ruby_build - Installs the ruby-build to `/opt/ruby-build` and prepares Chef to use `ruby_install` LWRP.

# LWRP

## ruby_install
### Actions
- **install:** Builds and installs ruby, includes chruby functions via `/etc/profile.d/`.

### Attribute Parameters
- **definition:** This attribute defines ruby version. Should be in ruby-build definition list;
- **prefix:** Set install prefix for ruby-build, default is `/opt/rubies`;
- **build_ruby:** Build ruby from sources via ruby-build. `True` by default. If `False`, try to install system ruby package.

## ruby_set
### Actions
- **set:** Install chruby_auto helper to user's `.profile` and create `.rubyversion` in user's home directory.

### Attribute Parameters
- **definition:** Name attribute, define ruby version. Should be in ruby-build definition list;
- **username:** Target user;
- **install_bundler:** If `true`, bundler will be installed. Default is `true`.


# Usage

You must include `recipe[ruby_lwrp::default]` to your run list or via `include_recipe`. If you don't want to build ruby or use chruby, you may use `recipe[ruby_lwrp::ruby_build]` or `recipe[ruby_lwrp::chruby]` recipes.

## Example of ruby 1.9.3-p392 setup:

```
include_recipe 'ruby_lwrp::default'

ruby_install '1.9.3-p392' do
  action :install
end
ruby_set '1.9.3-p392' do
  action :set
  username 'alice'
end
```

See fixture cookbook in `tests/fixtures/cookbooks`.


# License and Maintainer

Maintainer:: LLC Express 42 (<cookbooks@express42.com>)

License:: MIT
