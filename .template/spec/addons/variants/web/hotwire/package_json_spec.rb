# frozen_string_literal: true

describe 'Hotwire Addon - package.json' do
  subject do
    JSON.parse(file('package.json').content)
  end

  describe 'Jest Config' do
    it 'adds the jest config' do
      expect(subject['jest']).to include('testRegex')
      expect(subject['jest']).to include('transform')
      expect(subject['jest']).to include('testEnvironment')
      expect(subject['jest']).to include('roots')
      expect(subject['jest']).to include('moduleDirectories')
    end
  end

  describe 'Development Dependencies' do
    it 'adds the jest dependencies' do
      expect(subject['devDependencies']).to include('jest')
      expect(subject['devDependencies']).to include('jest-environment-jsdom')
    end

    it 'adds the esbuild-jest dependency' do
      expect(subject['devDependencies']).to include('esbuild-jest')
    end
  end
end
