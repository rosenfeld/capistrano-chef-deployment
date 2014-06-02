# This ensures the commands are run out of the Bundler context. Otherwise some resources
# like gem_package could not work properly

require 'mixlib/shellout'

module MixlibShelloutBundlerFix
  def run_command
    Bundler.with_clean_env do
      super
    end
  end
end
::Mixlib::ShellOut.include MixlibShelloutBundlerFix if defined?(Bundler)
