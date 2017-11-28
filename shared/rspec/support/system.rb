RSpec.configure do |config|
  config.before(:each, type: :system) do
    # use headless_chrome, by default
    driven_by :headless_chrome

    # uncomment to use chrome browser
    # driven_by :selenium, using: :chrome

    # uncomment to use firefox browser
    # driven_by :selenium, using: :firefox
  end
end
