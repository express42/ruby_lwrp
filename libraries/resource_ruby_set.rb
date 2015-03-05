require 'chef/resource'

class Chef
  class Resource
    class RubySet < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :ruby_set
        @provider = Chef::Provider::RubyLwrpSet
        @action = :set
        @allowed_actions = [:set]
        @definition = name
      end

      def definition(arg = nil)
        set_or_return(:definition, arg, kind_of: String, required: true)
      end

      def username(arg = nil)
        set_or_return(:username, arg, kind_of: String, required: true)
      end

      def install_bundler(arg = nil)
        set_or_return(:install_bundler, arg, kind_of: [FalseClass, TrueClass], default: true)
      end
    end
  end
end
