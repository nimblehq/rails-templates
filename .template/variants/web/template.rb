def apply_web_variant!
  use_source_path __dir__

  copy_file '.eslintignore'
  copy_file '.eslintrc'
  copy_file '.scss-lint.yml'

  template '.nvmrc.tt'
  copy_file '.npmrc'

  apply 'Gemfile.rb'
  apply 'app/template.rb'
  apply 'config/template.rb'
  apply 'package.json.rb'
  apply 'Dangerfile.rb'

  # Add-ons - [Optional]
  apply '.template/addons/bootstrap/template.rb' if yes? install_addon_prompt 'Bootstrap'
  apply '.template/addons/slim/template.rb' if yes? install_addon_prompt 'Slim Template Engine'

  after_bundle do
    use_source_path __dir__

    # Install Webpacker and Typescript
    rails_command('webpacker:install')
    rails_command('webpacker:install:typescript')

    # To fix webpack CLI that is raising `The command moved into a separate package: @webpack-cli/serve`.
    # This should be resolved after upgrading Webpacker > 6 but it is not stable yet.
    run 'yarn add webpack-cli'

    insert_into_file 'config/webpack/development.js', after: %r{const environment.*\n} do
      <<~EOT

        const config = environment.toWebpackConfig();
        config.output.filename = "js/[name]-[hash].js"
      EOT
    end

    # Fix the default Rails template that does not put trailing commas
    run 'yarn run lint --fix'

    apply 'config/webpack/template.rb'
    apply 'spec/template.rb'
  end
end

apply_web_variant!
