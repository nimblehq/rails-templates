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

unless File.exist?('postcss.config.js')
  create_file 'postcss.config.js',
              <<~POSTCSS
                module.exports = {
                  plugins: [
                    require('autoprefixer'),
                  ]
                }
              POSTCSS
end

# Install dependencies
run 'yarn add i18n-js@3.8.0'
run 'yarn add sass'
run 'yarn add esbuild'
run 'yarn add postcss postcss-cli autoprefixer'

run 'yarn add --dev eslint'
run 'yarn add --dev stylelint@^15'
run 'yarn add --dev @nimblehq/eslint-config-nimble-core@2.8.0'
run 'yarn add --dev @nimblehq/stylelint-config-nimble@1.1.0'

# Setup scripts
run 'npm pkg set scripts.eslint="eslint . --color"'
run 'npm pkg set scripts.eslint:fix="eslint . --color --fix"'
run 'npm pkg set scripts.stylelint="stylelint **/*.scss --color"'
run 'npm pkg set scripts.stylelint:fix="stylelint **/*.scss --color --fix"'
run 'npm pkg set scripts.codebase="yarn eslint && yarn stylelint"'
run 'npm pkg set scripts.codebase:fix="yarn eslint:fix && yarn stylelint:fix"'

source_stylesheet = 'app/assets/stylesheets/application.scss'
bundled_stylesheet = 'app/assets/builds/application.css'
bundled_stylesheet_base_options = [
  '--source-map-urls=absolute',
  '--load-path=node_modules'
]
production_bundled_stylesheet_options = bundled_stylesheet_base_options + [
  '--style=compressed'
]

run %(npm pkg set scripts.build="node app/javascript/build.js")
run %(
  npm pkg set scripts.build:css-dev="sass\
  #{source_stylesheet} #{bundled_stylesheet} #{bundled_stylesheet_base_options.join(' ')}"
)
run %(
  npm pkg set scripts.build:css="yarn build:css-dev #{production_bundled_stylesheet_options.join(' ')}"
)
run %(npm pkg set scripts.postcss="postcss\
  public/assets/*.css --dir public/assets --config ./")
run %(
  npm pkg set scripts.build:postcss="postcss\
  app/assets/builds/*.css --dir app/assets/builds --config ./",
)
