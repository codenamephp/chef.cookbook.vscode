require 'spec_helper'

describe 'codenamephp_vscode_package' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_vscode_package

  context 'With minimal properties' do
    recipe do
      codenamephp_vscode_package 'Install vscode'
    end

    it {
      is_expected.to install_package('code')
    }
  end

  context 'With properties' do
    recipe do
      codenamephp_vscode_package 'Install vscode' do
        package_name 'some package'
      end
    end

    it {
      is_expected.to install_package('some package')
    }
  end
end
