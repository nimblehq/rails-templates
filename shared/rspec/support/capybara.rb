require 'capybara'
require 'capybara/poltergeist'

Capybara.default_host = 'http://0.0.0.0:3000'
Capybara.javascript_driver = :poltergeist

Rails.application.routes.default_url_options[:host] = '0.0.0.0:3000'