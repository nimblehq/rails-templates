require 'shellwords'

# Variables
APP_NAME = app_name
RUBY_VERSION = '2.6.5'

def apply_template!
  apply 'lib/config.rb'
  apply 'lib/rspec.rb'
  apply 'lib/test_env.rb'
  apply 'lib/linter.rb'
  apply 'lib/bullet.rb'
  apply 'lib/i18n.rb'

  # TODO: Recheck if we need this
  delete_git
  delete_test_folder

  directory 'rails_docker', './', force: true, recursive: false
  directory 'rails_docker/bin', 'bin', mode: :preserve
  directory 'shared', './', force: true, recursive: false

  setup_config

  # Setup Javascripts
  directory 'shared/app/javascript', 'app/javascript'
  insert_into_file 'app/javascript/packs/application.js', after: "require\(\"channels\"\)\n" do
    <<~EOT
    
    import 'initializers/';
    import 'screens/';
    EOT
  end

  # Setup Stylesheets
  remove_file 'app/assets/stylesheets/application.css'
  directory 'shared/app/assets/stylesheets', 'app/assets/stylesheets'

  # Setup base application controller including the useful concerns
  directory 'shared/app/controllers', 'app/controllers'

  remove_turbolinks

  setup_rack_deflater
  setup_rails_i18n
  setup_i18n_js
  setup_test_env
  setup_bullet
  setup_linters
  setup_gitignore

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  environment(nil, env: 'test') do
    <<~EOT
      # Do not fallback to assets pipeline if a precompiled asset is missed.
      config.assets.compile = false

    EOT
  end
end

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

def source_paths
  Array(super) + [current_directory]
end

def delete_git
  FileUtils.rm_rf("#{current_directory}/#{app_name}/.git")
end

def delete_test_folder
  FileUtils.rm_rf('test')
end

def remove_turbolinks
  gsub_file('app/views/layouts/application.html.erb', %r{, 'data-turbolinks-track': 'reload'}, '')
  gsub_file('app/javascript/packs/application.js', %r{^require\(\"turbolinks\"\).start\(\)\n}, '')
  gsub_file('package.json', %r{"turbolinks": .+\n}, '')
end

def setup_rack_deflater
  environment do
    <<~EOT
      # Compress the responses to reduce the size of html/json controller responses.
      config.middleware.use Rack::Deflater

    EOT
  end
end

def setup_gitignore
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
end

after_bundle do
  run 'spring stop'

  # Devise configuration
  generate 'devise:install'
  insert_into_file 'config/environments/development.rb', after: %r{config.action_mailer.perform_caching.+\n} do
    <<-EOT

  config.action_mailer.default_url_options = { 
    host: ENV.fetch('MAILER_DEFAULT_HOST'), 
    port: ENV.fetch('MAILER_DEFAULT_PORT')
  }
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

  setup_rspec
end

apply_template!
