def setup_test_env
  disable_animations
end

def disable_animations
  insert_into_file 'config/environments/test.rb',
                   "require_relative '../../spec/support/disable_animation'\n\n",
                   before: "Rails.application.configure do\n"

  insert_into_file 'config/environments/test.rb',
                   "\n\t# Disable all animation during tests\n \tconfig.middleware.use Rack::NoAnimations\n",
                   after: "# Settings specified here will take precedence over those in config/application.rb.\n"
end