require_relative '../test_helper'

describe 'Template' do
  it 'creates pronto linters configuration files' do
    assert File.exist?('.flayignore')
    assert File.exist?('.pronto.yml')
    assert File.exist?('.rubocop.yml')
    assert File.exist?('config.reek')
  end

  it 'creates semaphore configuration example file' do
    assert File.exist?('.semaphore.yml')
  end

  it 'creates ruby configuration files' do
    assert File.exist?('.ruby-gemset')
    assert File.exist?('.ruby-version')
  end

  it 'creates editor configuration file' do
    assert File.exist?('.editorconfig')
  end

  it 'creates Procfiles' do
    assert File.exist?('Procfile')
    assert File.exist?('Procfile.dev')
  end

  it 'creates README file' do
    assert File.exist?('README.md')
  end

  describe '/bin' do
    it 'creates the common project bash scripts' do
      assert File.exist?('bin/envsetup.sh')
      assert File.executable?('bin/envsetup.sh')

      assert File.exist?('bin/start.sh')
      assert File.executable?('bin/start.sh')

      assert File.exist?('bin/test.sh')
      assert File.executable?('bin/test.sh')
    end
  end

  describe '/config' do
    it 'creates the Figaro configuration for application variables' do
      assert File.exist?('config/application.yml')
    end

    it 'creates the database configuration' do
      assert File.exist?('config/database.yml')
    end

    it 'creates the Sidekiq configuration' do
      assert File.exist?('config/sidekiq.yml')
    end
  end
end
