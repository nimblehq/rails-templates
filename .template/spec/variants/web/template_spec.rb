describe 'Web variant - template' do
  it 'creates the eslint configuration files' do
    expect(file('.eslintignore')).to exist
    expect(file('.eslintrc')).to exist
  end

  it 'creates sass lint configuration file' do
    expect(file('.scss-lint.yml')).to exist
  end

  it 'creates the .nvmrc file' do
    expect(file('.nvmrc')).to exist
  end

  it 'creates the npm configuration file' do
    expect(file('.npmrc')).to exist
  end

  it 'creates the TypeScript config file' do
    expect(file('tsconfig.json')).to exist
  end

  it 'creates the asset manifest file' do
    expect(file('test')).to exist
    expect(file('app/assets/config/manifest.js')).not_to contain('//= link_directory ../stylesheets .css')
    expect(file('app/assets/config/manifest.js')).to contain('//= link_tree ../builds')
  end
end
