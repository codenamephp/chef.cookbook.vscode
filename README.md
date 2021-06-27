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
