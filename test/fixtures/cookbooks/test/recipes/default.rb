user 'create user 1' do
  manage_home true
  username 'user1'
end
user 'create user 2' do
  manage_home true
  username 'user2'
end
user 'create user 3' do
  manage_home true
  username 'user3'
end

codenamephp_vscode_repository 'Install apt repo'
codenamephp_vscode_package 'Install vscode'

codenamephp_vscode_extension 'eamodio.gitlens' do
  user 'user1'
end
codenamephp_vscode_extension 'github.vscode-pull-request-github' do
  user 'user1'
end
codenamephp_vscode_extension 'eamodio.gitlens' do
  user 'user1'
  action :install_or_update
end

codenamephp_vscode_extension 'github.vscode-pull-request-github' do
  user 'user2'
end

codenamephp_vscode_extensions 'Install extensions for user2' do
  users_extensions 'user2' => %w(eamodio.gitlens chef-software.chef rebornix.ruby), 'user3' => %w(davidanson.vscode-markdownlint)
end

codenamephp_vscode_extensions 'Install extensions for user3' do
  users_extensions 'user3' => %w(github.vscode-pull-request-github)
end
