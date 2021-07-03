require 'spec_helper'

describe 'codenamephp_vscode_extension' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_vscode_extension

  let(:result) { double(exitstatus: 0, stdout: '') }
  let(:shellout) { double(run_command: result, error!: nil) }

  context 'Install with minimal properties' do
    recipe do
      codenamephp_vscode_extension 'test.extension' do
        user 'some user'
      end
    end

    it 'should install extension because it is not in the list of installed extensions' do
      allow(File).to receive(:expand_path).and_call_original
      expect(File).to receive(:expand_path).with('~some user').and_return('/home/some-user')
      expect(CodenamePHP::VSCode::CommandLine).to receive(:extension_installed?).with('test.extension', 'some user', '/home/some-user').and_return(false)

      is_expected.to run_execute('code --install-extension test.extension').with(user: 'some user', environment: { 'HOME' => '/home/some-user' })
    end

    it 'should not install the extension because it is in the list of installed extensions' do
      allow(File).to receive(:expand_path).and_call_original
      expect(File).to receive(:expand_path).with('~some user').and_return('/home/some-user')
      expect(CodenamePHP::VSCode::CommandLine).to receive(:extension_installed?).with('test.extension', 'some user', '/home/some-user').and_return(true)

      is_expected.to_not run_execute('code --install-extension test.extension').with(user: 'some user', environment: { 'HOME' => '/home/some-user' })
    end
  end

  context 'Install with custom home_dir' do
    recipe do
      codenamephp_vscode_extension 'test.extension' do
        user 'some user'
        home_dir 'some home dir'
      end
    end

    it 'Should use custom user home' do
      allow(File).to receive(:expand_path).and_call_original
      expect(File).to_not receive(:expand_path).with('~some user')
      expect(CodenamePHP::VSCode::CommandLine).to receive(:extension_installed?).with('test.extension', 'some user', 'some home dir').and_return(false)

      is_expected.to run_execute('code --install-extension test.extension').with(user: 'some user', environment: { 'HOME' => 'some home dir' })
    end
  end

  context 'Install Or Update with custom home_dir' do
    recipe do
      codenamephp_vscode_extension 'test.extension' do
        user 'some user'
        home_dir 'some home dir'
        action :install_or_update
      end
    end

    it 'Should use custom user home' do
      is_expected.to run_execute('code --install-extension test.extension --force').with(user: 'some user', environment: { 'HOME' => 'some home dir' })
    end
  end

  context 'Install with minimal properties' do
    recipe do
      codenamephp_vscode_extension 'test.extension' do
        user 'some user'
        home_dir '/home/some-user'
        action :uninstall
      end
    end

    it 'should uninstall extension because it is in the list of installed extensions' do
      expect(CodenamePHP::VSCode::CommandLine).to receive(:extension_installed?).with('test.extension', 'some user', '/home/some-user').and_return(true)

      is_expected.to run_execute('code --uninstall-extension test.extension').with(user: 'some user', environment: { 'HOME' => '/home/some-user' })
    end

    it 'should not uninstall the extension because it is not in the list of installed extensions' do
      expect(CodenamePHP::VSCode::CommandLine).to receive(:extension_installed?).with('test.extension', 'some user', '/home/some-user').and_return(false)

      is_expected.to_not run_execute('code --uninstall-extension test.extension').with(user: 'some user', environment: { 'HOME' => '/home/some-user' })
    end
  end
end
