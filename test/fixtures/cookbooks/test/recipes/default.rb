user 'create user 1' do
  manage_home true
  username 'user1'
end
user 'create user 2' do
  manage_home true
  username 'user2'
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
