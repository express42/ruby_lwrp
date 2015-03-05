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
