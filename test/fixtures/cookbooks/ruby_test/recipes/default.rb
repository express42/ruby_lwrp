include_recipe 'apt'
include_recipe 'ruby_lwrp'

user 'test_user' do
  home '/home/test_user'
  supports manage_home: true
end

ruby_install '2.1.5' do
  action :install
end

ruby_set '2.1.5' do
  action :set
  username 'test_user'
end
