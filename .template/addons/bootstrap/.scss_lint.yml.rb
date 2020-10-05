# frozen_string_literal: true

insert_into_file '.scss-lint.yml', after: "'coverage/**'\n" do
  <<~YAML.indent(2)
    - 'vendor/**'
  YAML
end
