# Chef Cookbook
[![CI](https://github.com/codenamephp/chef.cookbook.vscode/actions/workflows/ci.yml/badge.svg)](https://github.com/codenamephp/chef.cookbook.vscode/actions/workflows/ci.yml)

This cookbook provides resources to install VS Code and extensions

## Requirements

### Supported Platforms

- Debian Buster

### Chef

- Chef 15.3+

### Cookbook Depdendencies

## Usage

Use the resources in a wrapper cookbook and set the parameters as required.

A typical installation will look something like this:

```ruby
codenamephp_vscode_repository 'Install apt repo'
codenamephp_vscode_package 'Install vscode'
```

## Resources

### Repository
Manages the apt repository in the sources list so the package can be installed using apt.

#### Actions
- `install`: Installs the repository
- `uninstall`: Uninstalls the repository

#### Properties
- `uri`: The uri to the package repository
- `arch`: The cpu architectures that are supported by the repository
- `key`: The key the repository is signed with
- `distribution`: The distribution(s) the repository exists in
- `components`: The components that exist in the repository

#### Examples
```ruby
# Minimal config
codenamephp_vscode_repository 'Install apt repo'

# Custom config
codenamephp_vscode_repository 'add repository' do
  uri 'https://localhost'
  arch 'some arch'
  key 'https://localhost/key'
  distribution 'some dist'
  components %w(some components)
end
```
### Package
Manages the installation as package. The repository must be added first.

#### Actions
- `install`: Installs the vscode IDE
- `uninstall`: Uninstalls the vscode IDE

#### Properties
- `package_name`: The package to install

#### Examples
```ruby
# Minimal config
codenamephp_vscode_package 'Install vscode'

# Custom config
codenamephp_vscode_package 'Install vscode' do
  package_name 'code-insiders'
end
```

### Extension
Manages the installation of extensions for users. Each call can install a single extension for a single user.

#### Actions
- `install`: Installs the extension for the user. If the extension is already installed nothing happens
- `install_or_update`: Installs the extension for the given user or udpates it if the extension is already installed
- `uninstall`: Unsinstalls the extension for the user.

#### Properties
- `extension_name`: The extension to install, usually in the form 'vendor.extension', defaults to the resource name
- `user`: The user(name) to install the extension for
- `home_dir (optional)`: The home dir of the user. If not set it the resource tries to find it using the user

#### Examples
```ruby
# Minimal config
codenamephp_vscode_extension 'eamodio.gitlens' do
  user 'user1'
end

# With explicit extension_name
codenamephp_vscode_extension 'Install gitlens' do
  extension_name 'eamodio.gitlens'
  user 'user1'
end

# With explicit home_dir
codenamephp_vscode_extension 'eamodio.gitlens' do
  user 'user1'
  home '/var/home/user1'
end

# Install or Update
codenamephp_vscode_extension 'eamodio.gitlens' do
  user 'user1'
  action :install_or_update
end

# Uninstall
codenamephp_vscode_extension 'eamodio.gitlens' do
  user 'user1'
  action :uninstall
end
```

### Extensions
This resources installs multiple extensions for multiple users and expects as hash with the user as key and an array of extensions as value.
It uses `codenamephp_vscode_extension` internally

#### Actions
- `:install`: Installs the given extensions for the given users. If an extension is already installed no action is performed
- `:install_or_update`: Installs the given extensions for the given users or updates it if it's already installed
- `:uninstall`: removes the given extensions for the given users

#### Properties
- `users_extensions`: Hash with the users as keys and an array of extension names as strings as values that will be uninstalled

#### Examples
```ruby
# Minmal parameters
codenamephp_vscode_extensions 'Install extensions' do
  users_extensions 'user1' => %w[ext1 ext2], 'user2' => %w[ext2, ext3]
end

# Install or update
codenamephp_vscode_extensions 'Uninstall extensions' do
  action :install_or_update
  users_extensions 'user1' => %w[ext1 ext2], 'user2' => %w[ext2, ext3]
end

# Uninstall
codenamephp_vscode_extensions 'Uninstall extensions' do
  action :uninstall
  users_extensions 'user1' => %w[ext1 ext2], 'user2' => %w[ext2, ext3]
end
```
