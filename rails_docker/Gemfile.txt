source 'https://rubygems.org'
ruby '2.6.2'

# Backend
gem 'rails', '5.2.3' # Latest stable
gem 'pg' # Use Postgresql as database
gem 'puma' # Use Puma as the app server
gem 'mini_magick' # A ruby wrapper for ImageMagick or GraphicsMagick command line
gem 'pagy' # A pagination gem that is very light and fast
gem 'paranoia', '2.4.1' # Paranoia is a re-implementation of acts_as_paranoid for Rails 3 and Rails 4. Soft-deletion of records
gem 'ffaker' # A library for generating fake data such as names, addresses, and phone numbers.
gem 'fabrication' # Fabrication generates objects in Ruby. Fabricators are schematics for your objects, and can be created as needed anywhere in your app or specs.
gem 'sidekiq' # background processing for Ruby
gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'i18n-js' # A library to provide the I18n translations on the Javascript

# Authentications & Authorizations
gem 'devise' # Authentication solution for Rails with Warden
gem 'pundit' # Minimal authorization through OO design and pure Ruby classes

# Assets
gem 'sass-rails' # SASS
gem 'uglifier'

# Translations
# gem 'rails-i18n', '~> 5.1' # Translations for Rails
# gem 'devise-i18n' # Translations for Devise

group :development do
  gem 'foreman' # Manage Procfile-based applications
  gem 'better_errors' # Better error page for Rails and other Rack apps
  gem 'binding_of_caller' # Retrieve the binding of a method's caller in MRI 1.9.2+
  gem 'awesome_print' # Pretty print your Ruby objects with style -- in full color and with proper indentation
  gem 'guard-rubocop'
  gem 'guard-rspec' # Auto-run specs
  gem 'roadie-rails' # Mailers
  gem 'rubycritic', require: false # A Ruby code quality reporter
  gem 'spring' # Spring speeds up development by keeping your application running in the background.
  gem 'spring-commands-rspec' # This gem implements the rspec command for Spring.
  gem 'spring-watcher-listen', '2.0.1' # Makes Spring watch the filesystem for changes using Listen
end

group :development, :test do
  gem 'bullet' # help to kill N+1 queries and unused eager loading
  gem 'figaro' # Simple Rails app configuration
  gem 'pry-rails' # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'listen', '3.1.5' # Listens to file modifications
  gem 'letter_opener' # Preview mail in the browser instead of sending.
  gem 'sassc-rails' # Gem to generate scss source maps
  gem 'brakeman', require: false # A static analysis security vulnerability scanner for Ruby on Rails applications

  gem 'pronto'
  gem 'pronto-rubocop', require: false
  gem 'pronto-flay', require: false # analyzes code for structural similarities
  gem 'pronto-brakeman', require: false # analyzes code for security vulnerabilities
  gem 'pronto-dirty_words', require: false # analyzes code for  Seven Dirty Words
  gem 'pronto-rails_best_practices', require: false
  gem 'pronto-rails_schema', require: false
  gem 'pronto-reek', require: false
  gem 'pronto-scss', require: false
  gem 'pronto-eslint_npm', require: false
end

group :test do
  gem 'rspec-rails' # Rails testing engine
  gem 'rspec-retry' # Retry randomly failing rspec example.
  gem 'capybara', '>= 2.15' # Integration testing
  gem 'webdrivers' # Run Selenium tests more easily with automatic installation and updates for all supported webdrivers
  gem 'database_cleaner' # Use Database Cleaner
  gem 'shoulda-matchers' # Tests common Rails functionalities
  gem 'json_matchers' # Validate the JSON returned by your Rails JSON APIs
  gem 'webmock' # Library for stubbing and setting expectations on HTTP requests in Ruby
  gem 'simplecov', require: false # code coverage analysis tool for Ruby
  gem 'vcr' # Gem for recording test suite's HTTP interactions
  gem 'timecop' # Gem for time travel
end

group :production do
  gem 'rack-timeout' # Rack middleware which aborts requests that have been running for longer than a specified timeout.
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
