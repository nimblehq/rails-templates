# frozen_string_literal: true

insert_into_file 'Gemfile', after: /gem 'rails-i18n'.*\n/ do
  <<~RUBY
    gem 'i18n-js', '3.9.0' # A library to provide the I18n translations on the Javascript
  RUBY
end

insert_into_file 'Gemfile', after: /gem 'pundit'.*\n/ do
  <<~RUBY

    # Assets
    gem 'sprockets-rails' # The original asset pipeline for Rails
    gem 'cssbundling-rails' # Bundle and process CSS
    gem 'jsbundling-rails' # Bundle and transpile JavaScript
    # gem 'image_processing' # Use Active Storage variants
  RUBY
end

############################
# Group: :development, :test
############################

insert_into_file 'Gemfile', after: /gem 'danger'.*\n/ do
  <<~RUBY.indent(2)
    gem 'danger-eslint' # ESLint
  RUBY
end

insert_into_file 'Gemfile', after: /gem 'spring-watcher-listen'.*\n/ do
  <<~RUBY.indent(2)
    # gem 'web-console' # Use console on exceptions pages
  RUBY
end

##############
# Group: :test
##############

insert_into_file 'Gemfile', after: /gem 'rspec-retry'.*\n/ do
  <<~RUBY.indent(2)
    gem 'capybara' # Integration testing
    gem 'selenium-webdriver' # Ruby bindings for Selenium/WebDriver
    gem 'webdrivers' # Run Selenium tests more easily with automatic installation and updates for all supported webdrivers
  RUBY
end
