unified_mode true

property :uri, String, default: 'https://packages.microsoft.com/repos/code', description: 'The uri to use for the repository'
property :arch, String, default: 'amd64,arm64,armhf', description: 'The supported CPU architectures'
property :key, String, default: 'https://packages.microsoft.com/keys/microsoft.asc', description: 'The key the package is signed with'
property :distribution, String, default: 'stable', description: 'The distribution to use'
property :components, Array, default: ['main'], description: 'The components to install'

action :install do
  apt_repository 'vscode' do
    uri new_resource.uri
    arch new_resource.arch
    key new_resource.key
    distribution new_resource.distribution
    components new_resource.components
  end
end

action :uninstall do
  apt_repository 'vscode' do
    action :remove
  end
end
