# Usage

You must include `recipe[ruby::default]` to you run list or via `include_recipe`. If you don't want build ruby or use chruby, you may use `recipe[ruby::ruby_build]` or `recipe[ruby::chruby]` recipes.

## Example of ruby 1.9.3-p392 setup:

```
include_recipe 'ruby::default'

ruby_install '1.9.3-p392' do
  action :install
end
ruby_set '1.9.3-p392' do
  action :set
  username 'alice'
end
```

See fixture cookbook in `tests/fixtures/cookbooks`.
