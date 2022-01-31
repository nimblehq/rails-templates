INSTALL_BOOTSTRAP_ADDON = @cli.install_addon?('Bootstrap')
INSTALL_SLIM_TEMPLATE_ADDON = @cli.install_addon?('Slim Template Engine')

def apply_web_variant!
  use_source_path __dir__

  copy_file '.eslintrc'
  copy_file '.eslintignore'
  copy_file '.stylelintrc'
  copy_file '.stylelintignore'

  template '.nvmrc.tt'
  copy_file '.npmrc'
  apply '.tool-versions.rb'

  apply 'Gemfile.rb'
  apply 'package.json.rb'
  apply 'app/template.rb'
  apply 'config/template.rb'
  apply 'Dangerfile.rb'
  apply 'Procfile.dev.rb'

  apply '.gitignore.rb'

  # Add-ons - [Optional]
  apply '.template/addons/bootstrap/template.rb' if INSTALL_BOOTSTRAP_ADDON
  apply '.template/addons/slim/template.rb' if INSTALL_SLIM_TEMPLATE_ADDON

  after_bundle do
    use_source_path __dir__

    # Install Webpacker and Typescript
    rails_command('webpacker:install')
    rails_command('webpacker:install:typescript')

    # Generate translation file
    run 'bin/rake i18n:js:export'

    # Fix the default Rails template that does not put trailing commas
    run 'yarn run lint:fix'

    apply 'config/webpack/template.rb'
    apply 'spec/template.rb'
  end
end

apply_web_variant!
