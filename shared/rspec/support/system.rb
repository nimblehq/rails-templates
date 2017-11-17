RSpec.configure do |config|
  config.before(:each, type: :system) do
    # driven_by :selenium, using: :chrome
    # driven_by :selenium, using: :firefox
    driven_by :headless_chrome
  end
end
