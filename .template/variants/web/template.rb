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

  remove_turbolinks

  after_bundle do
    use_source_path __dir__

    # Use TypeScript by default
    rails_command('webpacker:install:typescript')

    # Fix the default Rails template that does not put trailing commas
    run 'yarn run lint --fix'

    apply 'config/webpack/template.rb'
    apply 'spec/template.rb'
  end
end

def remove_turbolinks
  if File.exist?('app/views/layouts/application.html.erb')
    gsub_file('app/views/layouts/application.html.erb', %r{, 'data-turbolinks-track': 'reload'}, '')
  else
    @template_errors.add <<~EOT
      Cannot Remove turbolinks from `application.html.erb` file
      Content: 'data-turbolinks-track': 'reload'
    EOT
  end

  if File.exist?('app/javascript/packs/application.js')
    gsub_file('app/javascript/packs/application.js', %r{import Turbolinks from "turbolinks"\n}, '')
    gsub_file('app/javascript/packs/application.js', %r{Turbolinks.start\(\)\n}, '')
  else
    @template_errors.add <<~EOT
      Cannot Remove turbolinks from `app/javascript/packs/application.js`
      Content: import Turbolinks from 'turbolinks';
      Content: Turbolinks.start();
    EOT
  end

  gsub_file('package.json', %r{"turbolinks": .+\n}, '')
end

apply_web_variant!
