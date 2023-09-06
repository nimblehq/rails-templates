# frozen_string_literal: true

xdescribe 'package.json' do
  subject do
    JSON.parse(file('package.json').content)
  end

  describe 'Scripts' do
    it 'adds the script for running eslint lint docs' do
      expect(subject['scripts']).to include('lint:docs:dev')
      expect(subject['scripts']).to include('lint:docs:yml')
      expect(subject['scripts']).to include('lint:docs:openapi')
      expect(subject['scripts']).to include('lint:docs:public')
    end

    it 'adds the script for building docs' do
      expect(subject['scripts']).to include('build:docs')
    end
  end

  describe 'Development Dependencies' do
    it 'adds spectral cli from stoplight dependency' do
      expect(subject['devDependencies']).to include('@stoplight/spectral-cli')
    end

    it 'adds swagger cli from apidevtools dependency' do
      expect(subject['devDependencies']).to include('@apidevtools/swagger-cli')
    end

    it 'adds eslint plugin for yml dependencies' do
      expect(subject['devDependencies']).to include('eslint-plugin-yml')
    end
  end
end
