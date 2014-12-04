# LWRP

## ruby_install
### Actions
- **install:** Builds and installs ruby, includes chruby functions via /etc/profile.d/.

### Attribute Parameters
- **definition:** This attribute defines ruby version. Should be in ruby-build definition list;
- **prefix:** Set install prefix for ruby-build, default is `/opt/rubies`;
- **build_ruby:** Build ruby from sources via ruby-build. `True` by default. If `False`, try to install system ruby package.

## ruby_set
### Actions
- **set:** Install chruby_auto helper to user .profile and create .rubyversion in user home directory.

### Attribute Parameters
- **definition:** Name attribute, define ruby version. Should be in ruby-build definition list;
- **username:** Target user.
- **install_bundler:** If `true`, bundler will be installed. Default is `true`.
