require 'chef/resource'

class Chef
  class Resource
    class RubyInstall < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :ruby_install
        @provider = Chef::Provider::RubyLwrpInstall
        @action = :install
        @allowed_actions = [:install]
        @definition = name
      end

      def definition(arg = nil)
        set_or_return(:definition, arg, kind_of: String, required: true)
      end

      def prefix(arg = nil)
        set_or_return(:prefix, arg, kind_of: String, default: '/opt/rubies')
      end

      def build_ruby(arg = nil)
        set_or_return(:build_ruby, arg, kind_of: [FalseClass, TrueClass], default: true)
      end
    end
  end
end
