require 'selenium-webdriver'
require 'capybara'

# https://github.com/rails/rails/pull/30876
Capybara.register_driver(:headless_chrome) do |app|
  # no-sandbox
  #   Because the user namespace is not enabled in the container by default
  # headless
  #   Runs without actually launching gui
  # disable-gpu
  #   Disables graphics processing unit(GPU) hardware acceleration
  # window-size
  #   sets default window size in case the smaller default size is not enough
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[no-sandbox headless disable-gpu window-size=1280,720] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

# https://github.com/rails/rails/pull/30638
Capybara.server = :puma, { Silent: true }
