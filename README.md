ruby Cookbook
=============

Description
-----------
Cookbook *ruby* builds various versions of ruby and installs them to */opt/rubies*. It uses [ruby-build](https://github.com/sstephenson/ruby-build) to build and install ruby and [chruby](https://github.com/postmodern/chruby) for switching between installed ruby versions.

Requirements
------------
- This cookbook version (0.1.x) tested only on Debian squeeze and Ubuntu 12.04 LTS, but may work on other Debian-based OS.

Usage
-----
You must include `recipe[ruby::default]` to you run list or via `include_recipe`. If you don't want build ruby or use chruby, you may use `recipe[ruby::ruby_build]` or `recipe[ruby::chruby]` recipes.

### Example ruby 1.9.3-p392 setup: ###

	include_recipe "ruby::default"

	ruby_install "1.9.3-p392" do
		action :install
	end
	ruby_set "1.9.3-p392" do
		action :set
		username "alice"
	end

Recipes
-----
#### ruby_build
Installs the ruby-build to /opt/ruby-build and prepares Chef to use `ruby_install` LWRP.
#### ruby::chruby
Installs the Chruby to /opt/chruby and prepares Chef to `ruby_set` the LWRP.
#### ruby::default
Includes `ruby_build` and `chruby` recipes.

Attributes
----------

#### ruby::ruby_build
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['ruby']['ruby_build']['install_path']</tt></td>
    <td>String</td>
    <td>Location where ruby_build will be installed</td>
    <td>/opt/ruby-build</td>
  </tr>
  <tr>
    <td><tt>['ruby']['ruby_build']['git_url']</tt></td>
    <td>String</td>
    <td>ruby_build git url</td>
    <td>git://github.com/sstephenson/ruby-build.git</td>
  </tr>
  <tr>
    <td><tt>['ruby']['ruby_build']['git_ref']</tt></td>
    <td>String</td>
    <td>ruby_build git ref</td>
    <td>master</td>
  </tr>
  <tr>
    <td><tt>['ruby']['ruby_build']['install_pkg']</tt></td>
    <td>Array</td>
    <td>packages for ruby_build</td>
    <td>See <i>ruby_build.rb</i></td>
  </tr>
</table>

#### ruby::chruby
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['ruby']['chruby']['install_path']</tt></td>
    <td>String</td>
    <td>Location where chruby will be installed</td>
    <td>/opt/chruby</td>
  </tr>
  <tr>
    <td><tt>['ruby']['chruby']['home_prefix']</tt></td>
    <td>String</td>
    <td>Path to user home directories</td>
    <td>/home</td>
  </tr>
  <tr>
    <td><tt>['ruby']['chruby']['git_url']</tt></td>
    <td>String</td>
    <td>chruby git url</td>
    <td>git://github.com/postmodern/chruby.git</td>
  </tr>
  <tr>
    <td><tt>['ruby']['chruby']['git_ref']</tt></td>
    <td>String</td>
    <td>chruby git ref</td>
    <td>master</td>
  </tr>
  <tr>
    <td><tt>['ruby']['chruby']['install_pkg']</tt></td>
    <td>Array</td>
    <td>packages for chruby</td>
    <td>make, git-core</td>
  </tr>
</table>

Resources/Providers
-------------------

### ruby_install
##### Actions
- **install:** builds and installs ruby, includes chruby fuctions via /etc/profile.d/

#### Attribute Parameters
- **definition:** This attribute defines ruby version. Should be in ruby-build definition list;
- **prefix:** Set install prefix for ruby-build, default is */opt/rubies*;
- **build_ruby:** Build ruby from sources via ruby-build. *True* by default. If false, try to install package ruby-\<definition\>.

### ruby_set
##### Actions
- **set:** install chruby_auto helper to user .profile and create .rubyversion in user home directory.

#### Attribute Parameters
- **definition:** name attribute, define ruby version. Should be in ruby-build definition list;
- **username:** target user.
- **install_bundler:** if true, bundler will be installed. Default is true.



License and Authors
-------------------
Author:: LLC Express 42 (<info@express42.com>)

Copyright (C) 2012-2013 LLC Express 42

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.