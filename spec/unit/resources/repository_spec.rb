require 'spec_helper'

describe 'codenamephp_vscode_repository' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_vscode_repository

  context 'With minimal properties' do
    recipe do
      codenamephp_vscode_repository 'add repository'
    end

    it {
      is_expected.to add_apt_repository('vscode').with(
        uri: 'https://packages.microsoft.com/repos/code',
        arch: 'amd64,arm64,armhf',
        key: ['https://packages.microsoft.com/keys/microsoft.asc'],
        distribution: 'stable',
        components: %w(main)
      )
    }
  end

  context 'With properties' do
    recipe do
      codenamephp_vscode_repository 'add repository' do
        uri 'https://localhost'
        arch 'some arch'
        key 'https://localhost/key'
        distribution 'some dist'
        components %w(some components)
      end
    end

    it {
      is_expected.to add_apt_repository('vscode').with(
        uri: 'https://localhost',
        arch: 'some arch',
        key: ['https://localhost/key'],
        distribution: 'some dist',
        components: %w(some components)
      )
    }
  end
end
