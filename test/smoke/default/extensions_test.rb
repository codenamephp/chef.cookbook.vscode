describe command('sudo -uuser2 code --list-extensions') do
  its('stdout') { should match(/eamodio\.gitlens/i) }
  its('stdout') { should match(/chef-software\.chef/i) }
  its('stdout') { should match(/rebornix\.ruby/i) }
end
describe command('sudo -uuser3 code --list-extensions') do
  its('stdout') { should match(/davidanson\.vscode-markdownlint/i) }
  its('stdout') { should match(/github\.vscode-pull-request-github/i) }
end
