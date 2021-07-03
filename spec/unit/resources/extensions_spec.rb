require 'spec_helper'

describe 'codenamephp_vscode_extensions' do
  step_into :codenamephp_vscode_extensions

  context 'Install' do
    recipe do
      codenamephp_vscode_extensions 'Install extensions' do
        users_extensions 'user1' => %w(ext1 ext2), 'user2' => %w(ext2 ext3)
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs extensions for each user using the resource' do
      expect(chef_run).to install_codenamephp_vscode_extension('Install extension ext1 for user user1').with(extension_name: 'ext1', user: 'user1')
      expect(chef_run).to install_codenamephp_vscode_extension('Install extension ext2 for user user1').with(extension_name: 'ext2', user: 'user1')
      expect(chef_run).to install_codenamephp_vscode_extension('Install extension ext2 for user user2').with(extension_name: 'ext2', user: 'user2')
      expect(chef_run).to install_codenamephp_vscode_extension('Install extension ext3 for user user2').with(extension_name: 'ext3', user: 'user2')
    end
  end

  context 'Install' do
    recipe do
      codenamephp_vscode_extensions 'Install extensions' do
        users_extensions 'user1' => %w(ext1 ext2), 'user2' => %w(ext2 ext3)
        action :install_or_update
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs extensions for each user using the resource' do
      expect(chef_run).to install_or_update_codenamephp_vscode_extension('Install or update extension ext1 for user user1').with(extension_name: 'ext1', user: 'user1')
      expect(chef_run).to install_or_update_codenamephp_vscode_extension('Install or update extension ext2 for user user1').with(extension_name: 'ext2', user: 'user1')
      expect(chef_run).to install_or_update_codenamephp_vscode_extension('Install or update extension ext2 for user user2').with(extension_name: 'ext2', user: 'user2')
      expect(chef_run).to install_or_update_codenamephp_vscode_extension('Install or update extension ext3 for user user2').with(extension_name: 'ext3', user: 'user2')
    end
  end

  context 'Uninstall' do
    recipe do
      codenamephp_vscode_extensions 'Uninstall extensions' do
        users_extensions 'user1' => %w(ext1 ext2), 'user2' => %w(ext2 ext3)
        action :uninstall
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'uninstalls extensions for each user using the resource' do
      expect(chef_run).to uninstall_codenamephp_vscode_extension('Uninstall extension ext1 for user user1').with(extension_name: 'ext1', user: 'user1')
      expect(chef_run).to uninstall_codenamephp_vscode_extension('Uninstall extension ext2 for user user1').with(extension_name: 'ext2', user: 'user1')
      expect(chef_run).to uninstall_codenamephp_vscode_extension('Uninstall extension ext2 for user user2').with(extension_name: 'ext2', user: 'user2')
      expect(chef_run).to uninstall_codenamephp_vscode_extension('Uninstall extension ext3 for user user2').with(extension_name: 'ext3', user: 'user2')
    end
  end
end
