# frozen_string_literal: true

describe 'OpenAPI addon - template' do
  it 'creates the .spectral.yml file' do
    expect(file('.spectral.yml')).to exist
  end

  it 'creates Fly deployment files' do
    expect(file('fly.toml')).to exist
  end

  it 'creates the HTML template file' do
    expect(file('public/openapi.html')).to exist
  end

  it 'creates Github actions workflows' do
    expect(file('.github/workflows/lint_docs.yml')).to exist
    expect(file('.github/workflows/deploy_mock_server.yml')).to exist
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

  describe '/docs/openapi' do
    it 'exists' do
      expect(file('docs/openapi')).to exist
    end

    it 'creates the openapi.yml file' do
      expect(file('docs/openapi/openapi.yml')).to exist
    end

    it 'creates the responses.yml file' do
      expect(file('docs/openapi/responses.yml')).to exist
    end

    it 'creates the schemas.yml file' do
      expect(file('docs/openapi/schemas.yml')).to exist
    end

    context 'given the examples directory' do
      it 'creates the a keep file in the requests folder' do
        expect(file('docs/openapi/examples/requests/.keep')).to exist
      end

      it 'creates the a health.json file in the responses folder' do
        expect(file('docs/openapi/examples/responses/health.json')).to exist
      end
    end

    context 'given the paths directory' do
      it 'creates the health.yml file' do
        expect(file('docs/openapi/paths/health.yml')).to exist
      end
    end

    context 'given the request_bodies directory' do
      it 'creates the a keep file' do
        expect(file('docs/openapi/request_bodies/.keep')).to exist
      end
    end

    context 'given the responses directory' do
      it 'creates the a default_error.yml file' do
        expect(file('docs/openapi/responses/default_error.yml')).to exist
      end
    end

    context 'given the schemas directory' do
      it 'creates the a keep file in the requests directory' do
        expect(file('docs/openapi/schemas/requests/.keep')).to exist
      end

      it 'creates the heath.yml file in the responses directory' do
        expect(file('docs/openapi/schemas/responses/health.yml')).to exist
      end

      it 'creates the error.yml file in the shared directory' do
        expect(file('docs/openapi/schemas/shared/error.yml')).to exist
      end
    end
  end
end
