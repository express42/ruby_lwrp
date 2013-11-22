#
# Cookbook Name:: ruby
# Recipe:: chruby
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

chruby_path = "#{cache_path}/chruby"
chruby_install_path = node['ruby']['chruby']['install_path']
chruby_repository = node['ruby']['chruby']['git_url']
chruby_reference = node['ruby']['chruby']['git_ref']

node['ruby']['chruby']['install_pkgs'].each do |pkg|
  package pkg
end

execute "install_chruby" do
  cwd chruby_path
  environment "PREFIX" => chruby_install_path
  command "make install"
  action :nothing
end

git chruby_path do
  action :sync
  repository chruby_repository
  reference chruby_reference
  notifies :run, "execute[install_chruby]", :immediately
end

file "/etc/profile.d/chruby.sh" do
  action :create
  content "source #{chruby_install_path}/share/chruby/chruby.sh"
  owner "root"
  group "root"
  mode "0644"
  backup false
end

file "/etc/profile.d/chruby-path.sh" do
  action :create
  content "export PATH=$PATH:#{chruby_install_path}/bin"
  owner "root"
  group "root"
  mode "0644"
  backup false
end
