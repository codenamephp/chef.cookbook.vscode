module CodenamePHP
  module VSCode
    ##
    # Abstraction to the code cli
    #
    class CommandLine
      ##
      # Runs a code command on the command line with the given user and home_dir. The home_dir is set as HOME envvar
      #
      def self.execute_command(command, user, home_dir)
        command = Mixlib::ShellOut.new(
          "code #{command}",
          user: user,
          environment: { 'HOME' => home_dir }
        )
        result = command.run_command
        return result if result.exitstatus == 0

        command.error!
      end

      ##
      # Gets a list of installed extension using the cli command --list-extensions
      # The output will be split by newline and all empty values are removed and the extension name are lowercased
      # for easier comparison
      #
      def self.installed_extensions(user, home_dir)
        extensions = execute_command('--list-extensions', user, home_dir).stdout.split("\n")
        extensions.delete_if(&:empty?).map(&:downcase)
      rescue
        []
      end

      ##
      # Checks if an extension is installed by getting the installed extensions and checking if the given extension
      # is in the array. Since the names in the array are lowercased the given extension is also lowercased.
      #
      def self.extension_installed?(extension_name, user, home_dir)
        installed_extensions(user, home_dir).include?(extension_name.downcase)
      end
    end
  end
end
