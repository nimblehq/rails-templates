# frozen_string_literal: true

file 'spec/support/devise.rb', <<~RUBY
  RSpec.configure do |config|
    config.include Devise::Test::ControllerHelpers, type: :controller
    config.include Devise::Test::ControllerHelpers, type: :view
    config.include Devise::Test::IntegrationHelpers, type: :request
  end
RUBY
