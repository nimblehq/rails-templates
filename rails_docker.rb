require 'shellwords'

# Add the current directory to the path Thor uses to look up files

def current_directory
  @current_directory ||=
    if __FILE__ =~ %r{\Ahttps?://}
      require 'tmpdir'
      tempdir = Dir.mktmpdir('rails-templates')
      at_exit { FileUtils.remove_entry(tempdir) }
      git clone: [
              '--quiet',
              '--depth=1',
              'https://github.com/nimblehq/rails-templates.git',
              tempdir
          ].map(&:shellescape).join(' ')
      tempdir
    else
      File.expand_path(File.dirname(__FILE__))
    end
end

FileUtils.rm_rf("#{current_directory}/#{app_name}/.git")

def source_paths
  Array(super) + [current_directory]
end

apply 'lib/config.rb'
apply 'lib/rspec.rb'
apply 'lib/test_env.rb'
apply 'lib/linter.rb'
apply 'lib/bullet.rb'
apply 'lib/i18n.rb'

# Gemfile
remove_file 'Gemfile'
copy_file 'rails_docker/Gemfile.txt', 'Gemfile'

# Docker
remove_file 'Dockerfile'
copy_file 'rails_docker/Dockerfile', 'Dockerfile'
gsub_file 'Dockerfile', '#{app_name}', "#{app_name}"

remove_file 'docker-compose.yml'
copy_file 'rails_docker/docker-compose.yml', 'docker-compose.yml'
gsub_file 'docker-compose.yml', '#{app_name}', "#{app_name}"

copy_file 'rails_docker/docker-compose.dev.yml', 'docker-compose.dev.yml'
gsub_file 'docker-compose.dev.yml', '#{app_name}', "#{app_name}"

copy_file 'rails_docker/docker-compose.test.yml', 'docker-compose.test.yml'
gsub_file 'docker-compose.test.yml', '#{app_name}', "#{app_name}"

remove_file '.dockerignore'
copy_file 'rails_docker/.dockerignore', '.dockerignore'
gsub_file '.dockerignore', '#{app_name}', "#{app_name}"

copy_file 'rails_docker/.env', '.env'
gsub_file '.env', '#{app_name}', "#{app_name}"

# Shell script for boot the app inside the Docker image (production)
copy_file 'rails_docker/start.sh', 'bin/start.sh'
run 'chmod +x bin/start.sh'

# Shell script for run tests inside the Docker image
copy_file 'rails_docker/test.sh', 'bin/test.sh'
run 'chmod +x bin/test.sh'

# remove test folder
run 'rm -rf test/'

# rvm
run 'touch .ruby-version && echo 2.6.5 > .ruby-version'
run "touch .ruby-gemset && echo #{app_name} > .ruby-gemset"

# Add custom configs
setup_config

# Remove Turbolink attributes from `application.html.erb` file
gsub_file('app/views/layouts/application.html.erb', %r{, 'data-turbolinks-track': 'reload'}, '')

# Setup Javascript
directory 'shared/app/javascript', 'app/javascript'
# Remove Turbolinks from `application.js` file
gsub_file('app/javascript/packs/application.js', %r{^require\(\"turbolinks\"\).start\(\)\n}, '')
# Remove Turbolinks from `package.json` file
gsub_file('package.json', %r{"turbolinks": .+\n}, '')

insert_into_file 'app/javascript/packs/application.js', after: "require\(\"channels\"\)\n" do
  <<~EOT

    import 'translations/translations';
    
    import 'initializers/';
    import 'screens/';
  EOT
end

# Add i18n-js plugin to package.json
insert_into_file 'package.json', after: %r{"@rails/ujs": .+\n} do
  <<~EOT
    "i18n-js": "^3.0.11",
  EOT
end

# Add @nimbl3/eslint-config-nimbl3 plugin to package.json
insert_into_file 'package.json', before: %r{"version": .+\n} do
  <<~EOT
      "devDependencies": {
        "@nimbl3/eslint-config-nimbl3": "2.1.1"
      },
  EOT
end

# Setup Stylesheets
remove_file 'app/assets/stylesheets/application.css'
directory 'shared/app/assets/stylesheets', 'app/assets/stylesheets'

# Setup base application controller including the useful concerns
directory 'shared/app/controllers', 'app/controllers'

# Add Procfile
copy_file 'shared/Procfile', 'Procfile'
copy_file 'shared/Procfile.dev', 'Procfile.dev'

# Setup EditorConfig
copy_file 'shared/.editorconfig', '.editorconfig'

# Setup .npmrc
copy_file 'shared/.npmrc', '.npmrc'

after_bundle do
  run 'spring stop'

  # Setup i18n configurations
  setup_rails_i18n
  setup_i18n_js

  # Devise configuration
  generate 'devise:install'
  insert_into_file 'config/environments/development.rb', after: "config.assets.raise_runtime_errors = true\n\n" do
    "  config.action_mailer.default_url_options = { host: \"localhost\", port: 3000 }"
  end

  # Add Rack Deflater to reduce response size to `config/application.rb`
  environment do
    <<~EOT
      # Compress the responses to reduce the size of html/json controller responses.
      config.middleware.use Rack::Deflater

    EOT
  end

  # Setup test env
  setup_test_env

  # Setup Bullet gem to detect N+1 queries
  setup_bullet

  # rspec
  setup_rspec

  # Modified Guardfile
  remove_file 'Guardfile'
  copy_file 'shared/Guardfile', 'Guardfile'

  # Shell script to setup the Docker-based development environment
  copy_file 'rails_docker/envsetup.sh', 'bin/envsetup.sh'
  run 'chmod +x bin/envsetup.sh'

  # Modified README file
  remove_file 'README.md'
  copy_file 'shared/README.md', 'README.md'

  # Setup linters
  setup_linters

  # CI configuration
  copy_file 'shared/.semaphore.yml', '.semaphore.yml'

  append_to_file '.gitignore' do
    <<~EOT

      # Ignore folder information and IDE-specific files
      .DS_Store
      .idea/*

      # Ignore the test coverage results from SimpleCov
      /coverage

      # Ignore pronto configuration files
      .pronto.yml
    EOT
  end

  # Add i18n-js plugin to webpack
  insert_into_file 'config/webpack/environment.js', after: "const { environment } = require('@rails/webpacker')\n" do
    <<~EOT
      const webpack = require('webpack');
      
      const plugins = [
        new webpack.ProvidePlugin({
          // Translations
          I18n: 'i18n-js',
        })
      ]
  
      environment.config.set('plugins', plugins);
    EOT
  end

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  environment(nil, env: 'test') do
    <<~EOT
      # Do not fallback to assets pipeline if a precompiled asset is missed.
      config.assets.compile = false

    EOT
  end
end
