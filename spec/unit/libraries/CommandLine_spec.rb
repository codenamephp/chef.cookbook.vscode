require 'spec_helper'

describe 'CodenamePHP::VSCode::CommandLine' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  let(:error) { double(stdout: '') }
  let(:result) { double(error!: nil, stdout: '', exitstatus: 0) }
  let(:command) { double(run_command: nil, error!: nil) }

  context 'execute_command' do
    it 'should run the command and return the result if exitstatus is 0' do
      expect(Mixlib::ShellOut).to receive(:new).with('code some-command', user: 'some user', environment: { 'HOME' => 'some home dir' }).and_return(command)
      expect(command).to receive(:run_command).and_return(result)
      expect(result).to receive(:exitstatus).and_return(0)

      returnedResult = CodenamePHP::VSCode::CommandLine.execute_command('some-command', 'some user', 'some home dir')

      expect(returnedResult).to be(result)
    end

    it 'should return error! when exit status is not 0' do
      expect(Mixlib::ShellOut).to receive(:new).with('code some-command', user: 'some user', environment: { 'HOME' => 'some home dir' }).and_return(command)
      expect(command).to receive(:run_command).and_return(result)
      expect(result).to receive(:exitstatus).and_return(1)
      expect(command).to receive(:error!).and_return(error)

      returnedResult = CodenamePHP::VSCode::CommandLine.execute_command('some-command', 'some user', 'some home dir')

      expect(returnedResult).to be(error)
    end
  end

  context 'installed_extensions' do
    it 'should call execute_command and build array from stdout with filtered empty values and lowercased' do
      expect(CodenamePHP::VSCode::CommandLine).to receive(:execute_command).with('--list-extensions', 'some user', 'some home dir').and_return(result)
      expect(result).to receive(:stdout).and_return("\nextension1\nExteNsion2\n\nExtension3\n")

      returnedResult = CodenamePHP::VSCode::CommandLine.installed_extensions('some user', 'some home dir')

      expect(returnedResult).to eq(%w(extension1 extension2 extension3))
    end

    it 'should return empty array on error' do
      expect(CodenamePHP::VSCode::CommandLine).to receive(:execute_command).and_raise('RuntimeError')

      returnedResult = CodenamePHP::VSCode::CommandLine.installed_extensions('some user', 'some home dir')

      expect(returnedResult).to eq([])
    end
  end

  context 'extension_installed?' do
    it 'should call installed_extensions and return true if the lowercased extension exists in the array' do
      expect(CodenamePHP::VSCode::CommandLine).to receive(:installed_extensions).with('some user', 'some home dir').and_return(%w(ext1 ext2 ext3))

      expect(CodenamePHP::VSCode::CommandLine.extension_installed?('Ext3', 'some user', 'some home dir')).to be true
    end

    it 'should call installed_extensions and return false if the lowercased extension exists in not the array' do
      expect(CodenamePHP::VSCode::CommandLine).to receive(:installed_extensions).with('some user', 'some home dir').and_return(%w(ext1 ext2 ext3))

      expect(CodenamePHP::VSCode::CommandLine.extension_installed?('Ext4', 'some user', 'some home dir')).to be false
    end
  end
end
