describe package('code') do
  it { should be_installed }
end

describe command('sudo -uuser1 code -v') do
  its('stdout') { should match(/(\d+\.)?(\d+\.)?(\*|\d+)/i) }
end
