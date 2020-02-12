require 'shellwords'

# Variables
APP_NAME = app_name
RUBY_VERSION = '2.6.5'

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
directory 'rails_docker', './', force: true, recursive: false

# Shell script for boot the app inside the Docker image (production)
copy_file 'rails_docker/bin/start.sh', 'bin/start.sh', mode: :preserve

# Shell script for run tests inside the Docker image
copy_file 'rails_docker/bin/test.sh', 'bin/test.sh', mode: :preserve

# remove test folder
run 'rm -rf test/'

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
  copy_file 'shared/Guardfile', 'Guardfile', force: true

  # Shell script to setup the Docker-based development environment
  copy_file 'rails_docker/bin/envsetup.sh', 'bin/envsetup.sh', mode: :preserve

  # Modified README file
  copy_file 'shared/README.md', 'README.md', force: true

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
