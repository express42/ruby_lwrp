require 'spec_helper'

describe package('build-essential') do
  it { should be_installed }
end

describe package('git-core') do
  it { should be_installed }
end

describe package('make') do
  it { should be_installed }
end

describe file('/opt/ruby-build') do
  it { should be_directory }
end

describe file('/opt/ruby-build/bin/ruby-build') do
  it { should be_file }
end

describe file('/opt/chruby') do
  it { should be_directory }
end

describe file('/opt/chruby/bin/chruby-exec') do
  it { should be_file }
end

describe file('/etc/profile.d/chruby.sh') do
  it { should be_file }
  it { should contain 'source /opt/chruby/share/chruby/chruby.sh' }
end

describe file('/etc/profile.d/chruby-path.sh') do
  it { should be_file }
  it { should contain 'export PATH=$PATH:/opt/chruby/bin' }
end

describe file('/opt/rubies/2.1.5/bin/ruby') do
  it { should be_file }
end

describe file('/home/vagrant/.ruby-version') do
  it { should be_file }
  it { should contain '2.1.5' }
end

describe file('/home/vagrant/.profile') do
  it { should be_file }
  it { should contain 'source /opt/chruby/share/chruby/auto.sh' }
end
