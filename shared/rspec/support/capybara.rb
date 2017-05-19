require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.default_host = 'http://0.0.0.0:3000'
Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 15
Capybara.wait_on_first_by_default = 15

Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: false,
    phantomjs_options: [
      '--ssl-protocol=any'
    ],
    window_size: [2048, 2048]
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Rails.application.routes.default_url_options[:host] = '0.0.0.0:3000'

RSpec.configure do |config|
  config.after(:each, js: true) do
    Capybara.reset_sessions!
  end
end
