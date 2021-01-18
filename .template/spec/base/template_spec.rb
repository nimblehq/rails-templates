describe 'Base template' do
  it 'creates Rubocop configuration files' do
    expect(file('.rubocop.yml')).to exist
  end

  it 'creates Ruby configuration files' do
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

  it 'creates Danger configuration files' do
    expect(file('Dangerfile')).to exist
  end

  it 'creates Reek configuration files' do
    expect(file('.reek.yml')).to exist
  end

end
