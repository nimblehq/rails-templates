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
run 'yarn add i18n-js@3.8.0'
run 'yarn add sass'
run 'yarn add esbuild'

run 'yarn add --dev @nimblehq/eslint-config-nimble@2.2.1'
run 'yarn add --dev stylelint'
run 'yarn add --dev stylelint-config-sass-guidelines'
run 'yarn add --dev stylelint-config-property-sort-order-smacss'
# TODO: Check again after removing Webpacker, need to use version 8
# https://github.com/bjankord/stylelint-config-sass-guidelines/issues/203#issuecomment-955620774
run 'yarn add --dev postcss@8.4.5'

# Setup scripts
source_javascript = 'app/javascript/application.js'
bundled_javascript = 'app/assets/builds'
source_stylesheet = 'app/assets/stylesheets/application.scss'
bundled_stylesheet = 'app/assets/builds/application.css'

run 'npm set-script eslint "eslint . --color"'
run 'npm set-script eslint:fix "eslint . --color --fix"'
run 'npm set-script stylelint "stylelint **/*.scss --color"'
run 'npm set-script stylelint:fix "stylelint **/*.scss --color --fix"'
run 'npm set-script lint "yarn eslint && yarn stylelint"'
run 'npm set-script lint:fix "yarn eslint:fix && yarn stylelint:fix"'

run %(npm set-script build "esbuild #{source_javascript} --bundle --sourcemap --outdir=#{bundled_javascript}")
run %(npm set-script build:css "sass #{source_stylesheet} #{bundled_stylesheet} --no-source-map --load-path=node_modules")
