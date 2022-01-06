package_json_file = 'package.json'

run 'yarn init -yp'
gsub_file package_json_file, /.*version.*/, ''
gsub_file package_json_file, /.*main.*/, ''
gsub_file package_json_file, /.*author.*/, ''
gsub_file package_json_file, /.*license.*/, ''

# Install dependencies
run 'yarn add i18n-js@^3.8.0'
run 'yarn add --dev @nimblehq/eslint-config-nimble@^2.2.1'

# Setup scripts
insert_into_file package_json_file, after: %r{"private":.+\n} do
  <<~EOT
    "scripts": {
      "lint": "eslint . --color",
      "lint:fix": "eslint . --color --fix"
    },
  EOT
end
