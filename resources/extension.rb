unified_mode true

property :extension_name, String, name_property: true, description: 'The complete name of the extension, usually vendor.extensionName'
property :user, String, required: true, description: 'The user to install the extension for since vscode extensions are not global'
property :home_dir, String, default: lazy { ::File.expand_path("~#{user}") }, description: 'The users home dir if it deviates from the default'

action :install do
  execute "code --install-extension #{new_resource.extension_name}" do
    user new_resource.user
    environment({ 'HOME' => new_resource.home_dir })
    not_if { CodenamePHP::VSCode::CommandLine.extension_installed?(new_resource.extension_name, new_resource.user, new_resource.home_dir) }
  end
end

action :install_or_update do
  execute "code --install-extension #{new_resource.extension_name} --force" do
    user new_resource.user
    environment({ 'HOME' => new_resource.home_dir })
  end
end

action :uninstall do
  execute "code --uninstall-extension #{new_resource.extension_name}" do
    user new_resource.user
    environment({ 'HOME' => new_resource.home_dir })
    only_if { CodenamePHP::VSCode::CommandLine.extension_installed?(new_resource.extension_name, new_resource.user, new_resource.home_dir) }
  end
end
