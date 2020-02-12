require 'shellwords'

# Variables
APP_NAME = app_name
RUBY_VERSION = '2.6.5'

def apply_template!
  # TODO: Recheck if we need this
  delete_git
  delete_test_folder

  directory 'rails_docker', './', force: true, recursive: false
  directory 'rails_docker/bin', 'bin', mode: :preserve
  directory 'shared', './', force: true, recursive: false

  # Setup config
  remove_file 'config/database.yml'
  directory 'shared/config', 'config',
  add_sidekiq_config
  add_mailer_config

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
  setup_i18n
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

  after_bundle do
    run 'spring stop'

    # Devise configuration
    generate 'devise:install'

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

    # Setup rspec
    generate "rspec:install"
    copy_file 'shared/rspec/.rspec', '.rspec', force: true

    FileUtils.cp_r "#{current_directory}/shared/rspec/.", 'spec/'
    # remove the .rspec file from rspec folder
    run 'rm -rf spec/.rspec'
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

def add_sidekiq_config
  insert_into_file 'config/application.rb', after: %r{config.generators.system_tests.+\n} do
    <<-EOT
    
    # Set the queuing backend to `Sidekiq`
    # 
    # Be sure to have the adapter's gem in your Gemfile
    # and follow the adapter's specific installation
    # and deployment instructions.
    config.active_job.queue_adapter = :sidekiq

    # Prefix the queue name of all jobs with Rails ENV
    config.active_job.queue_name_prefix = Rails.env
    EOT
  end
end

def add_mailer_config
  insert_into_file 'config/environments/development.rb', after: %r{config.action_mailer.perform_caching.+\n} do
    <<-EOT

  config.action_mailer.default_url_options = { 
    host: ENV.fetch('MAILER_DEFAULT_HOST'), 
    port: ENV.fetch('MAILER_DEFAULT_PORT')
  }
    EOT
  end
end

def setup_i18n
  inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
    "  include Localization\n"
  end

  gsub_file 'app/views/layouts/application.html.erb', /<html>/ do
    "<html lang='<%= I18n.locale %>'>"
  end

  environment(nil, env: 'development') do
    <<~EOT
      # Automatically generate the `translation.js` files
      config.middleware.use I18n::JS::Middleware

    EOT
  end

  insert_into_file 'app/javascript/packs/application.js', after: "require\(\"channels\"\)\n" do
    <<~EOT

    import 'translations/translations';
    EOT
  end

  insert_into_file 'package.json', after: %r{"@rails/ujs": .+\n} do
    <<~EOT
    "i18n-js": "^3.0.11",
    EOT
  end

  append_to_file '.gitignore' do
    <<~EOT

      # Ignore i18n.js generated files
      # If deploy to heroku with git, please remove this as it prevents the files to be committed
      /app/javascript/translations/translations.js
    EOT
  end
end

def setup_rack_deflater
  environment do
    <<~EOT
      # Compress the responses to reduce the size of html/json controller responses.
      config.middleware.use Rack::Deflater

    EOT
  end
end

def setup_bullet
  environment(nil, env: 'development') do
    <<~EOT
      # Configure Bullet gem to detect N+1 queries
      config.after_initialize do
        Bullet.enable        = true
        Bullet.bullet_logger = true
        Bullet.console       = true
        Bullet.rails_logger  = true
        Bullet.add_footer    = true
      end

    EOT
  end

  environment(nil, env: 'test') do
    <<~EOT
      # Configure Bullet gem to detect N+1 queries
      config.after_initialize do
        Bullet.enable                      = true
        Bullet.bullet_logger               = true
        Bullet.raise                       = true
        Bullet.unused_eager_loading_enable = false
      end

    EOT
  end
end

def setup_linters
  directory 'shared/linters', './'

  insert_into_file 'package.json', before: %r{"version": .+\n} do
    <<~EOT
      "devDependencies": { 
        "@nimbl3/eslint-config-nimbl3": "2.1.1"
      },
    EOT
  end
end

def setup_test_env
  disable_animations
end

def disable_animations
  insert_into_file 'config/environments/test.rb', before: %r{Rails.application.configure do} do
    <<~EOT
      require_relative '../../spec/support/disable_animation'

    EOT
  end

  environment(nil, env: 'test') do
    <<~EOT
      # Disable all animation during tests
      config.middleware.use Rack::NoAnimations

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

apply_template!
