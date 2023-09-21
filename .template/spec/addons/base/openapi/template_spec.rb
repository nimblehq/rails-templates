# frozen_string_literal: true

describe 'OpenAPI addon - template' do
  it 'creates the .spectral.yml file' do
    expect(file('.spectral.yml')).to exist
  end

  it 'adds dependencies to package.json' do
    file_content = JSON.parse(file('package.json').content)['devDependencies']

    expect(file_content).to include('eslint')
    expect(file_content).to include('@nimblehq/eslint-config-nimble')
    expect(file_content).to include('@apidevtools/swagger-cli')
    expect(file_content).to include('@stoplight/spectral-cli')
    expect(file_content).to include('eslint-plugin-yml')
  end

  it 'adds scripts to package.json' do
    file_content = JSON.parse(file('package.json').content)['scripts']

    expect(file_content).to include('lint:docs:yml')
    expect(file_content).to include('lint:docs:openapi')
    expect(file_content).to include('lint:docs:dev')
    expect(file_content).to include('lint:docs:public')
    expect(file_content).to include('build:docs')
  end

  it 'adds /public/openapi.yml to .gitignore' do
    expect(file('.gitignore')).to contain('/public/openapi.yml')
  end

  describe '/docs/openapi' do
    it 'exists' do
      expect(file('/docs/openapi')).to exist
    end

    it 'contains the default folders' do
      expect(file('docs/openapi/examples')).to exist
      expect(file('docs/openapi/paths')).to exist
      expect(file('docs/openapi/request_bodies')).to exist
      expect(file('docs/openapi/responses')).to exist
      expect(file('docs/openapi/schemas')).to exist
    end

    it 'contains the default files' do
      expect(file('docs/openapi/examples/requests/.keep')).to exist
      expect(file('docs/openapi/examples/responses/health.json')).to exist
      expect(file('docs/openapi/paths/health.yml')).to exist
      expect(file('docs/openapi/request_bodies/.keep')).to exist
      expect(file('docs/openapi/responses/default_error.yml')).to exist
      expect(file('docs/openapi/schemas/requests/.keep')).to exist
      expect(file('docs/openapi/schemas/responses/health.yml')).to exist
      expect(file('docs/openapi/schemas/shared/error.yml')).to exist

      expect(file('docs/openapi/openapi.yml')).to exist
      expect(file('docs/openapi/responses.yml')).to exist
      expect(file('docs/openapi/schemas.yml')).to exist
    end
  end
end
