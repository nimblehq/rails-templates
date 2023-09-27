# frozen_string_literal: true

append_to_file '.gitignore' do
  <<~IGNORE

    # Ignore generated OpenAPI file
    /public/openapi.yml
  IGNORE
end
