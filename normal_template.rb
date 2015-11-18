# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
      [File.expand_path(File.dirname(__FILE__))]
end

def generate_database_yml
  <<-EOF
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5

development:
  <<: *default
  host:     <%= ENV['DB_HOST'] %>
  port:     <%= ENV['DB_PORT'] %>
  username: postgres
  database: #{app_name}_development

test:
  <<: *default
  host:     <%= ENV['DB_HOST'] %>
  port:     <%= ENV['DB_PORT'] %>
  username: postgres
  database: #{app_name}_test

production:
  url: <%= ENV['DATABASE_URL'] %>
  EOF
end

def modify_guard_file
  <<-EOF
rspec_options = {
  cmd: 'zeus rspec',
  results_file: 'tmp/guard_rspec_results.txt'
}

guard :rspec, rspec_options do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.("controllers/\#{m[1]}_controller"),
      rspec.spec.("features/\#{m[1]}")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.app_controller)  { "\#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.("features/\#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.("features/\#{m[1]}") }
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
  EOF
end

def modify_spec_helper
  <<-EOF
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.order = :random

  Kernel.srand config.seed

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

  EOF
end


def modify_rails_helper
  <<-EOF
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "\#{::Rails.root}/spec/fabricators"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!
end
  EOF
end


def generate_rubocop_yml
  <<-EOF
AllCops:
  RunRailsCops: true
  Exclude:
    - 'vendor/**/*'
    - 'db/**/*'
    - 'bin/**/*'
    - 'Gemfile'
    - 'Gemfile.lock'
    - 'Rakefile'
    - 'zeus.rb'
    - 'Guardfile'
    - 'config/application.rb'
    - 'config/initializers/**/*'

Documentation:
  Enabled: false

Metrics/LineLength:
  Max: 120
  EOF
end

remove_file "Gemfile"

# Create gemfile
run "touch Gemfile"
add_source 'https://rubygems.org'

# Backend
gem 'rails', '4.2.4' # Latest stable
gem 'pg' # Use Postgresql as database
gem 'active_model_serializers' # ActiveModel::Serializer implementation and Rails hooks
gem 'carrierwave' # Classier solution for file uploads for Rails
gem 'carrierwave-aws' # Use the officially supported AWS-SDK library for S3 storage
gem 'mini_magick' # A ruby wrapper for ImageMagick or GraphicsMagick command line
gem 'kaminari' # A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Rails 3 and 4
gem 'chronic' # Chronic is a pure Ruby natural language date parser.
gem 'paranoia', '~> 2.1.3' # Paranoia is a re-implementation of acts_as_paranoid for Rails 3 and Rails 4. Soft-deletion of records
gem 'ffaker' # A library for generating fake data such as names, addresses, and phone numbers.
gem 'fabrication' # Fabrication generates objects in Ruby. Fabricators are schematics for your objects, and can be created as needed anywhere in your app or specs.

# Admin
gem 'rails_admin', git: 'git://github.com/sferik/rails_admin' # RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data.

# Authentications & Authorizations
gem 'devise' # Authentication solution for Rails with Warden
gem 'doorkeeper' # OAuth 2 provider
gem 'cancancan', '~> 1.10'     # Continuation of CanCan, the authorization Gem for Ruby on Rails.

# Assets
gem 'jquery-rails'             # Use jquery as the JavaScript library
gem 'font-awesome-sass'        # Font-Awesome Sass gem for use in Ruby/Rails projects
gem 'sass-rails'               # SASS

# Localization
gem 'phrase'

# Mailers
gem 'roadie-rails'

gem_group :development do
  gem 'better_errors' # Better error page for Rails and other Rack apps
  gem 'binding_of_caller' # Retrieve the binding of a method's caller in MRI 1.9.2+
  gem 'quiet_assets' # For cleaner logs
  gem 'bullet' # help to kill N+1 queries and unused eager loading
  gem 'awesome_print' # Pretty print your Ruby objects with style -- in full color and with proper indentation
  gem 'guard-rubocop'
end

gem_group :development, :test do
  gem 'figaro' # Simple Rails app configuration

  gem 'rspec-rails' # Rails testing engine
  gem 'guard-rspec' # Auto-run specs
  gem 'shoulda-matchers' # Tests common Rails functionalities
  gem 'zeus-parallel_tests' # Speeding up your tests by preloading a Rails app
  gem 'capybara' # Integration testing
  gem 'poltergeist' # Headless browser
  gem 'database_cleaner' # Use Database Cleaner

  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring' # Spring speeds up development by keeping your application running in the background.
  gem 'letter_opener' # Preview mail in the browser instead of sending.
end

inject_into_file 'Gemfile', after: "source 'https://rubygems.org'\n" do
  <<-EOF
ruby '2.2.3'
  EOF
end

inject_into_file 'Gemfile', after: "gem 'cancancan', '~> 1.10'\n" do
  <<-EOF

source 'https://rails-assets.org' do
  gem 'rails-assets-underscore' # Adds Underscore JS to the Rails asset pipeline
  gem 'rails-assets-jquery.cookie' # Adds jquery-cookie to the Rails asset pipeline
  gem 'rails-assets-animate-sass' # Animate.sass for the Rails assets pipeline
end

  EOF
end


remove_file 'docker-compose.yml'
create_file 'docker-compose.yml' do
  <<-EOF
db:
  image: postgres:9.4
  container_name: #{app_name}_db
  ports:
    - "5432:5432"
  EOF
end

remove_file '.dockerignore'
create_file '.dockerignore' do
  <<-EOF
.git
log
tmp
.rspec
docker-compose.yml
README.md
  EOF
end

# database.yml config
inside 'config' do
  remove_file 'database.yml'
  create_file 'database.yml' do
    generate_database_yml
  end
end

after_bundle do
  run "spring stop"

  # Devise configuration
  generate "devise:install"
  insert_into_file "config/environments/development.rb", after: "config.assets.raise_runtime_errors = true\n\n" do
    "  config.action_mailer.default_url_options = { host: \"localhost\", port: 3000 }"
  end

  #rspec
  generate "rspec:install"
  remove_file ".rspec"
  create_file ".rspec" do
    <<-EOF
--color
--require spec_helper
--format documentation
    EOF
  end

  inside 'spec' do
    #modified spec_helper
    remove_file "spec_helper.rb"
    create_file "spec_helper.rb" do
      modify_spec_helper
    end

    #modified rails_helper
    remove_file "rails_helper.rb"
    create_file "rails_helper.rb" do
      modify_rails_helper
    end

    # folder for fabricators
    run 'mkdir fabricators'
    run 'mkdir support'

    inside 'support' do
      create_file "capybara.rb" do
        <<-EOF
require 'capybara'
require 'capybara/poltergeist'

Capybara.default_host = 'http://0.0.0.0:3000'
Capybara.javascript_driver = :poltergeist

Rails.application.routes.default_url_options[:host] = '0.0.0.0:3000'
        EOF
      end

      create_file "shoulda_matchers.rb" do
        <<-EOF
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
        EOF
      end
    end
  end

  #guard
  run "guard init rspec"
  run "guard init rubocop"
  run "zeus-parallel_tests init"

  #Modified Guardfile
  remove_file "Guardfile"
  create_file "Guardfile" do
    modify_guard_file
  end

  #Modified custom_plan.rb
  remove_file "custom_plan.rb"
  create_file "custom_plan.rb" do
    <<-EOF
require 'zeus/parallel_tests'

class CustomPlan < Zeus::ParallelTests::Rails
  def test(*args)
    # can be anything matching Guard::RSpec :results_file option in the Guardfile
    ENV['GUARD_RSPEC_RESULTS_FILE'] = 'tmp/guard_rspec_results.txt'
    super
  end
end

Zeus.plan = CustomPlan.new
    EOF
  end

  #create .rubocop.yml
  create_file ".rubocop.yml" do
    generate_rubocop_yml
  end

  #shell script for run database on docker
  create_file "envsetup.sh" do
    <<-EOF
docker-machine start default
eval "$(docker-machine env default)"
docker-compose up -d
    EOF
  end
  FileUtils.chmod 0755, 'envsetup.sh'
end


