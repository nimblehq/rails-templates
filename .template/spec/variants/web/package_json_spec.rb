# frozen_string_literal: true

describe 'Web variant - package.json' do
  subject do
    JSON.parse(file('package.json').content)
  end

  describe 'Scripts' do
    it 'adds the script for running eslint' do
      expect(subject['scripts']).to include('eslint')
      expect(subject['scripts']).to include('eslint:fix')
    end

    it 'adds the script for running stylelint' do
      expect(subject['scripts']).to include('stylelint')
      expect(subject['scripts']).to include('stylelint:fix')
    end

    it 'adds the script for all lints' do
      expect(subject['scripts']).to include('codebase')
      expect(subject['scripts']).to include('codebase:fix')
    end

    it 'adds the script for bundling js' do
      expect(subject['scripts']).to include('build')
    end

    it 'adds the script for bundling css' do
      expect(subject['scripts']).to include('build:css')
    end

    it 'adds the script for bundling css in production' do
      expect(subject['scripts']).to include('build:css-production')
    end

    it 'adds the script for bundling postcss' do
      expect(subject['scripts']).to include('postcss')
      expect(subject['scripts']).to include('build:postcss')
    end
  end

  describe 'Dependencies' do
    it 'adds I18n-js dependency' do
      expect(subject['dependencies']).to include('i18n-js')
    end
  end

  describe 'Development Dependencies' do
    it 'adds Nimble eslint config dependency' do
      expect(subject['devDependencies']).to include('@nimblehq/eslint-config-nimble')
    end

    it 'adds postcss dependencies' do
      expect(subject['devDependencies']).to include('postcss')
      expect(subject['devDependencies']).to include('postcss-cli')
      expect(subject['devDependencies']).to include('autoprefixer')
    end

    it 'adds sass dependencies' do
      expect(subject['devDependencies']).to include('sass')
    end

    it 'adds esbuild dependencies' do
      expect(subject['devDependencies']).to include('esbuild')
    end

    it 'adds stylelint dependencies' do
      expect(subject['devDependencies']).to include('stylelint')
      expect(subject['devDependencies']).to include('@nimblehq/stylelint-config-nimble')
    end
  end
end
