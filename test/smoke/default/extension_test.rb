describe package('code') do
  it { should be_installed }
end

describe command('sudo -uuser1 code --list-extensions') do
  its('stdout') { should match(/eamodio\.gitlens/i) }
end
describe command('sudo -uuser1 code --list-extensions') do
  its('stdout') { should match(/github\.vscode-pull-request-github/i) }
end
describe command('sudo -uuser2 code --list-extensions') do
  its('stdout') { should match(/github\.vscode-pull-request-github/i) }
end
