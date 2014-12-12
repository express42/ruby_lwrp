include_recipe 'apt'
include_recipe 'ruby'

ruby_install '2.1.5' do
  action :install
end

ruby_set '2.1.5' do
  action :set
  username 'vagrant'
end
