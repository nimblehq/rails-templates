# frozen_string_literal: true

insert_into_file 'config/environments/test.rb', before: /Rails.application.configure do/ do
  <<~RUBY
    require_relative '../../spec/support/disable_animation'

  RUBY
end

insert_into_file 'config/environments/test.rb', before: /^end/ do
  <<~RUBY.indent(2)

    # Disable all animation during tests
    config.middleware.use Rack::NoAnimations

    # Do not fallback to assets pipeline if a precompiled asset is missing.
    config.assets.compile = false
  RUBY
end
