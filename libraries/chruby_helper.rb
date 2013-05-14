class Chef
  module Ruby
    module ScriptHelpers

      include Chef::Mixin::Command

      def exec_in_ruby_version(code, ruby_version, user = nil, chruby_install_path = node['ruby']['chruby']['install_path'])

        chruby_exec_string = "bash -c 'source #{chruby_install_path}/share/chruby/chruby.sh && chruby #{ruby_version} && #{code}'"

        if user
          exec_environment = { :user => user, :environment => { 'USER' => user, 'HOME' => Etc.getpwnam(user).dir} }
        else
          exec_environment = {}
        end

        ret = popen4(chruby_exec_string, exec_environment)
        ignored, status = Process::waitpid2 ret[0]
        out = ret[2].read
        err = ret[3].read

        if status.exitstatus != 0
          raise "#{chruby_exec_string} - returned #{status.exitstatus}, expected 0. STDOUT: #{out} STDERR: #{err}"
        end

        return out
      end

    end
  end
end
