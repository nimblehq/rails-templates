# frozen_string_literal: true

describe 'Web variant - template' do
  it 'creates the eslint configuration files' do
    expect(file('.eslintrc')).to exist
    expect(file('.eslintignore')).to exist
  end

  it 'creates the stylelint configuration files' do
    expect(file('.stylelintrc')).to exist
    expect(file('.stylelintignore')).to exist
  end

  it 'creates the .nvmrc file' do
    expect(file('.nvmrc')).to exist
  end

  it 'creates the npm configuration file' do
    expect(file('.npmrc')).to exist
  end

  it 'creates the asset manifest file' do
    expect(file('app/assets/config/manifest.js')).to exist
    expect(file('app/assets/config/manifest.js')).not_to contain('//= link_directory ../stylesheets .css')
    expect(file('app/assets/config/manifest.js')).to contain('//= link_tree ../builds')
  end

  it 'creates the docker asset precompile script' do
    expect(file('bin/docker-assets-precompile')).to exist
    expect(file('bin/docker-assets-precompile')).to be_executable
  end
end
