insert_into_file 'config/environments/test.rb', before: %r{Rails.application.configure do} do
  <<~EOT
      require_relative '../../spec/support/disable_animation'

  EOT
end

insert_into_file 'config/environments/test.rb', before: %r{^end} do
  <<-EOT

  # Disable all animation during tests
  config.middleware.use Rack::NoAnimations

  # Do not fallback to assets pipeline if a precompiled asset is missing.
  config.assets.compile = false
  EOT
end
