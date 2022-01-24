def apply_web_variant!
  use_source_path __dir__

  copy_file '.eslintignore'
  copy_file '.eslintrc'
  copy_file '.scss-lint.yml'

  template '.nvmrc.tt'
  copy_file '.npmrc'
  apply '.tool-versions.rb'

  apply 'Gemfile.rb'
  apply 'app/template.rb'
  apply 'config/template.rb'
  apply 'package.json.rb'
  apply 'Dangerfile.rb'
  apply 'Procfile.dev.rb'

  # Add-ons - [Optional]
  apply '.template/addons/bootstrap/template.rb' if yes? install_addon_prompt 'Bootstrap'
  apply '.template/addons/slim/template.rb' if yes? install_addon_prompt 'Slim Template Engine'

  after_bundle do
    use_source_path __dir__

    # Install Webpacker and Typescript
    rails_command('webpacker:install')
    rails_command('webpacker:install:typescript')

    # Generate translation file
    run 'bin/rake i18n:js:export'

    # Fix the default Rails template that does not put trailing commas
    run 'yarn run lint --fix'

    apply 'config/webpack/template.rb'
    apply 'spec/template.rb'
  end
end

apply_web_variant!
