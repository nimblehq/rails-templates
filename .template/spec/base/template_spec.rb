# frozen_string_literal: true

describe 'Base template' do
  it 'creates Rubocop configuration files' do
    expect(file('.rubocop.yml')).to exist
  end

  it 'creates Spectral configuration files' do
    expect(file('.spectral.yml')).to exist
  end

  it 'creates RVM configuration files' do
    expect(file('.ruby-gemset')).to exist
    expect(file('.ruby-version')).to exist
  end

  it 'creates ASDF configuration files' do
    expect(file('.tool-versions')).to exist
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

  it 'creates the .gitattributes without schema.db' do
    expect(file('.gitattributes')).to exist
    expect(file('.gitattributes')).not_to contain('db/schema.rb')
  end
end
