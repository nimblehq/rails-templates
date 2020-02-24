describe 'Base template spec' do
  it 'creates pronto linters configuration files' do
    expect(file('.flayignore')).to exist
    expect(file('.pronto.yml')).to exist
    expect(file('.rubocop.yml')).to exist
    expect(file('config.reek')).to exist
  end

  it 'creates semaphore configuration example file' do
    expect(file('.semaphore.yml')).to exist
  end

  it 'creates ruby configuration files' do
    expect(file('.ruby-gemset')).to exist
    expect(file('.ruby-version')).to exist
  end

  it 'creates editor configuration file' do
    expect(file('.editorconfig')).to exist
  end

  it 'creates Procfiles' do
    expect(file('Procfile')).to exist
    expect(file('Procfile.dev')).to exist
  end
end
