insert_into_file 'Gemfile', after: %r{gem 'rails-i18n'.*\n} do
  <<~EOT
    gem 'i18n-js', '3.5.1' # A library to provide the I18n translations on the Javascript
  EOT
end

insert_into_file 'Gemfile', after: %r{gem 'pundit'.*\n} do
  <<~EOT

    # Assets
    gem 'sprockets-rails' # The original asset pipeline for Rails
    gem 'cssbundling-rails' # Bundle and process CSS
    gem 'jsbundling-rails' # Bundle and transpile JavaScript
    # gem 'turbo-rails' # Hotwire's SPA-like page accelerator
    # gem 'stimulus-rails' # Hotwire's modest JavaScript framework
    # gem 'image_processing' # Use Active Storage variants
  EOT
end

############################
# Group: :development, :test
############################

insert_into_file 'Gemfile', after: %r{gem 'danger'.*\n} do
  <<~EOT.indent(2)
    gem 'danger-eslint' # ESLint
  EOT
end

insert_into_file 'Gemfile', after: %r{gem 'spring-watcher-listen'.*\n} do
  <<~EOT.indent(2)
    # gem 'web-console' # Use console on exceptions pages
  EOT
end

##############
# Group: :test
##############

insert_into_file 'Gemfile', after: %r{gem 'rspec-retry'.*\n} do
  <<~EOT.indent(2)
    gem 'capybara' # Integration testing
    gem 'selenium-webdriver' # Ruby bindings for Selenium/WebDriver
    gem 'webdrivers' # Run Selenium tests more easily with automatic installation and updates for all supported webdrivers
  EOT
end
