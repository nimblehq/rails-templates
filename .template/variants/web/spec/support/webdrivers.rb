# Configure VCR and WebMock to work with webdrivers
# https://github.com/titusfortner/webdrivers/wiki/Using-with-VCR-or-WebMock
if defined?(VCR)
  VCR.configure do |config|
    config.ignore_hosts(
      'chromedriver.storage.googleapis.com',
      'github.com/mozilla/geckodriver/releases',
      'selenium-release.storage.googleapis.com',
      'developer.microsoft.com/en-us/microsoft-edge/tools/webdriver'
    )
  end
end

if defined?(WebMock)
  allowed_sites = %w[
    https://chromedriver.storage.googleapis.com
    https://github.com/mozilla/geckodriver/releases
    https://selenium-release.storage.googleapis.com
    https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver
  ]
  WebMock.disable_net_connect!(allow_localhost: true, allow: allowed_sites)
end
