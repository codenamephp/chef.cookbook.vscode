unified_mode true

property :users_extensions, Hash, required: true, description: 'A hash where the username is the key and the value is an array with extension names as string for that user'

action :install do
  user_loop(new_resource.users_extensions, :install)
end

action :install_or_update do
  user_loop(new_resource.users_extensions, :install_or_update)
end

action :uninstall do
  user_loop(new_resource.users_extensions, :uninstall)
end

action_class do
  def user_loop(users_extensions, action)
    labels = { install: 'Install', install_or_update: 'Install or update', uninstall: 'Uninstall' }

    users_extensions.each do |user_name, extensions|
      extensions.each do |extension_name|
        codenamephp_vscode_extension "#{labels.fetch(action, '[Action without label!]')} extension #{extension_name} for user #{user_name}" do
          extension_name extension_name
          user user_name
          action action
        end
      end
    end
  end
end
