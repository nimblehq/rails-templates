# https://github.com/rails/rails/pull/30876
Capybara.register_driver(:headless_chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu window-size=1280,720] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

# https://github.com/rails/rails/pull/30638
Capybara.server = :puma, { Silent: true }
