file 'spec/support/devise.rb', <<~RUBY
  RSpec.configure do |config|
    config.include Devise::Test::ControllerHelpers, type: :controller
    config.include Devise::Test::ControllerHelpers, type: :view
  end
RUBY
