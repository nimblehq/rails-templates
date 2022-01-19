# Create package.json file
unless File.exist?('package.json')
  create_file 'package.json',
              <<~EOT
                {
                  "name": "#{APP_NAME}",
                  "private": "true"
                }
              EOT
end

# Install dependencies
run 'yarn add i18n-js@^3.8.0'
run 'yarn add --dev @nimblehq/eslint-config-nimble@^2.2.1'

# Setup scripts
insert_into_file 'package.json', after: %r{"private":.+\n} do
  <<~EOT.indent(2)
    "scripts": {
      "lint": "eslint . --color",
      "lint:fix": "eslint . --color --fix"
    },
  EOT
end
