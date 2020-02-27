describe 'Web variant - package.json' do
  subject do
    JSON.parse(file('package.json').content)
  end

  it 'adds the script for running eslint' do
    expect(subject['scripts']).to include('lint')
    expect(subject['scripts']).to include('lint:fix')
  end

  describe 'Dependencies' do
    it 'adds I18n-js dependency' do
      expect(subject['dependencies']).to include('i18n-js')
    end
  end

  describe 'Development Dependencies' do
    it 'adds Nimble eslint config dependency' do
      expect(subject['devDependencies']).to include('@nimbl3/eslint-config-nimbl3')
    end
  end
end
