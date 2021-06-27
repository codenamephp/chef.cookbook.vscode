unified_mode true

property :package_name, String, default: 'code', description: 'The package name to use when installing'

action :install do
  package new_resource.package_name do
    action :install
  end
end

action :uninstall do
  package new_resource.package_name do
    action :remove
  end
end
