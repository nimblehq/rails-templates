def apply_web_variant!
  use_source_path __dir__

  copy_file '.eslintignore'
  copy_file '.eslintrc'
  copy_file '.pronto_eslint_npm.yml'
  copy_file '.scss-lint.yml'

  copy_file '.npmrc'

  apply 'Gemfile.rb'
  apply 'app/template.rb'
  apply 'config/template.rb'
  apply 'package.json.rb'

  remove_turbolinks

  after_bundle do
    use_source_path __dir__

    # Fix the default rails template that does not put trailing commas
    run 'yarn run lint --fix'

    apply 'config/webpack/template.rb'
    apply 'spec/template.rb'
  end
end

def remove_turbolinks
  gsub_file('app/views/layouts/application.html.erb', %r{, 'data-turbolinks-track': 'reload'}, '')
  gsub_file('app/javascript/packs/application.js', %r{^require\(\"turbolinks\"\).start\(\)\n}, '')
  gsub_file('package.json', %r{"turbolinks": .+\n}, '')
end

apply_web_variant!
