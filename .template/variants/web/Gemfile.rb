insert_into_file 'Gemfile', after: %r{gem 'rails-i18n'.*\n} do
  <<~EOT
    gem 'i18n-js', '3.5.1' # A library to provide the I18n translations on the Javascript
  EOT
end

# TODO: Check to replace sass-rails with cssbundling-rails + sassc-rails
insert_into_file 'Gemfile', after: %r{gem 'pundit'.*\n} do
  <<~EOT

    # Assets
    gem 'webpacker', '~>5.2.0' # Transpile app-like JavaScript
    gem 'sass-rails' # SASS
    gem "turbo-rails" # Hotwire's SPA-like page accelerator
    gem "stimulus-rails" # Hotwire's modest JavaScript framework
    # gem "sprockets-rails" # The original asset pipeline for Rails
    # gem "jsbundling-rails" # Bundle and transpile JavaScript
    # gem "cssbundling-rails" # Bundle and process CSS
    # gem "sassc-rails" # Use Sass to process CSS
    # gem "image_processing" # Use Active Storage variants
  EOT
end

############################
# Group: :development, :test
############################

insert_into_file 'Gemfile', after: %r{gem 'letter_opener'.*\n} do
  <<-EOT
  gem 'sassc-rails' # Gem to generate scss source maps.
  EOT
end

insert_into_file 'Gemfile', after: %r{gem 'danger'.*\n} do
  <<-EOT
  gem 'danger-eslint' # ESLint
  gem 'scss_lint' # SCSS lint
  EOT
end

insert_into_file 'Gemfile', after: %r{gem 'spring-watcher-listen'.*\n} do
  <<-EOT
  # gem "web-console" # Use console on exceptions pages
  EOT
end

##############
# Group: :test
##############

insert_into_file 'Gemfile', after: %r{gem 'rspec-rails'.*\n} do
  <<-EOT
  # gem "capybara" # Integration testing
  # gem "selenium-webdriver" # Ruby bindings for Selenium/WebDriver
  # gem "webdrivers" # Run Selenium tests more easily with automatic installation and updates for all supported webdrivers
  EOT
end
