#
# Cookbook Name:: ruby_lwrp
# Provider:: install
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

def whyrun_supported?
  true
end

provides :ruby_install

action :install do
  ruby_build_install_path = node['ruby']['ruby_build']['install_path']

  if new_resource.build_ruby

    if ::File.exist?("#{new_resource.prefix}/#{new_resource.definition}/bin/ruby")
      Chef::Log.info("Ruby #{new_resource.definition} already installed into #{new_resource.prefix}/#{new_resource.definition}")
    else
      Chef::Log.info("Installing ruby #{new_resource.definition}...")

      execute "ruby_install-#{new_resource.definition}" do
        command "#{ruby_build_install_path}/bin/ruby-build #{new_resource.definition} #{new_resource.prefix}/#{new_resource.definition}"
      end.run_action(:run)

      new_resource.updated_by_last_action(true)
    end

  else
    ruby_package = package "ruby-#{new_resource.definition}" do
      action :nothing
    end

    ruby_package.run_action(:install)
    new_resource.updated_by_last_action(true) if ruby_package.updated_by_last_action?
  end
end
