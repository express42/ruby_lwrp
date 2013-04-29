#
# Cookbook Name:: ruby
# Provider:: set
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

action :set do

  chruby_install_path = node['ruby']['chruby']['install_path']
  home_directory = "#{node['ruby']['chruby']['home_prefix']}/#{new_resource.username}"
  profile_content = "source #{chruby_install_path}/share/chruby/auto.sh"

  add_to_profile_block = ruby_block "Install chruby autoload to #{new_resource.username} ~/.profile" do
    action :nothing
    block do
      if ::File.directory?(home_directory)
        ::File.open("#{home_directory}/.profile", 'a+') { |file|
            unless file.read =~ /#{profile_content}/
              file.seek(0,IO::SEEK_END)
              file.puts(profile_content)
            end
        }
      end
    end
  end

  ruby_version_file = file "#{home_directory}/.ruby-version" do
    action :nothing
    content new_resource.definition
    owner new_resource.username
    group new_resource.username
    mode "0644"
    backup false
  end
  
  add_to_profile_block.run_action(:create)
  ruby_version_file.run_action(:create)

  if add_to_profile_block.updated_by_last_action? or ruby_version_file.updated_by_last_action?
    new_resource.updated_by_last_action(true)
  end

end
