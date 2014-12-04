#
# Cookbook Name:: ruby
# Recipe:: ruby_build
#
# Copyright 2013, LLC Express 42
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

cache_path = Chef::Config['file_cache_path']

ruby_build_path = "#{cache_path}/ruby-build"
ruby_build_install_path = node['ruby']['ruby_build']['install_path']
ruby_build_repository = node['ruby']['ruby_build']['git_url']
ruby_build_reference = node['ruby']['ruby_build']['git_ref']

node['ruby']['ruby_build']['install_pkgs'].each do |pkg|
  package pkg
end

execute 'install_ruby-build' do
  cwd ruby_build_path
  environment 'PREFIX' => ruby_build_install_path
  command './install.sh'
  action :nothing
end

git ruby_build_path do
  action :sync
  repository ruby_build_repository
  reference ruby_build_reference
  notifies :run, 'execute[install_ruby-build]', :immediately
end
