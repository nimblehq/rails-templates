TEST_CONFIG = 'config/environments/test.rb'

insert_into_file TEST_CONFIG, before: %r{Rails.application.configure do} do
  <<~EOT
      require_relative '../../spec/support/disable_animation'

  EOT
end

insert_into_file TEST_CONFIG, before: %r{^end} do
  <<-EOT

  # Disable all animation during tests
  config.middleware.use Rack::NoAnimations
  EOT
end
