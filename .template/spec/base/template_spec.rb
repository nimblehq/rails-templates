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

  context 'OpenAPI docs' do
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
        expect(file('docs/openapi/request_bodies/.keepfile')).to exist
      end
    end

    context 'given the responses directory' do
      it 'creates the a default_error.yml file' do
        expect(file('docs/openapi/responses/default_error.yml')).to exist
      end
    end

    context 'given the schemas directory' do
      it 'creates the a keep file in the requests directory' do
        expect(file('docs/openapi/schemas/requests/.keepfile')).to exist
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
