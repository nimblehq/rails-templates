Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :shared
    with.library :rails
  end
end