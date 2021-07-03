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
