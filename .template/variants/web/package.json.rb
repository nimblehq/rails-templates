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

run 'yarn add --dev @nimblehq/eslint-config-nimble@2.2.1'
run 'yarn add --dev stylelint'
run 'yarn add --dev @nimblehq/stylelint-config-nimble'
# TODO: Check again after removing Webpacker, need to use version 8
# https://github.com/bjankord/stylelint-config-sass-guidelines/issues/203#issuecomment-955620774
run 'yarn add --dev postcss@8.4.5 postcss-cli autoprefixer'

# Setup scripts
run 'npm set-script eslint "eslint . --color"'
run 'npm set-script eslint:fix "eslint . --color --fix"'
run 'npm set-script stylelint "stylelint **/*.scss --color"'
run 'npm set-script stylelint:fix "stylelint **/*.scss --color --fix"'
run 'npm set-script codebase "yarn eslint && yarn stylelint"'
run 'npm set-script codebase:fix "yarn eslint:fix && yarn stylelint:fix"'

source_stylesheet = 'app/assets/stylesheets/application.scss'
bundled_stylesheet = 'app/assets/builds/application.css'
bundled_stylesheet_options = [
  '--no-source-map',
  '--load-path=node_modules'
]

run %(npm set-script build "node app/javascript/build.js")
run %(
  npm set-script build:css \
  "sass #{source_stylesheet} #{bundled_stylesheet} #{bundled_stylesheet_options.join(' ')}"
)
run %(npm set-script postcss "postcss public/assets/*.css --dir public/assets --config ./")
run %(
  npm set-script build:postcss \
  "postcss app/assets/builds/*.css --dir app/assets/builds --config ./",
)
