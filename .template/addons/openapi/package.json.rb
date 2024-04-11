# frozen_string_literal: true

# Create package.json file
unless File.exist?('package.json')
  create_file 'package.json',
              <<~JSON
                {
                  "name": "#{APP_NAME}",
                  "private": "true"
                }
              JSON
end

run 'yarn add --dev eslint'
run 'yarn add --dev @nimblehq/eslint-config-nimble-core@2.8.1'
run 'yarn add --dev @apidevtools/swagger-cli@4.0'
run 'yarn add --dev @stoplight/spectral-cli@6.8'
run 'yarn add --dev eslint-plugin-yml@1.8'

# Setup scripts
run 'npm pkg set scripts.lint:docs:yml="eslint docs/openapi --ext .yml --color"'
run 'npm pkg set scripts.lint:docs:openapi="spectral lint docs/openapi/openapi.yml -F error"'
run 'npm pkg set scripts.lint:docs:dev="yarn lint:docs:yml && yarn lint:docs:openapi"'
run 'npm pkg set scripts.lint:docs:public="yarn build:docs && eslint public/openapi.yml --color --no-ignore\
&& spectral lint public/openapi.yml -F error"'
run 'npm pkg set scripts.build:docs="swagger-cli bundle docs/openapi/openapi.yml --outfile public/openapi.yml --type\
yaml"'
