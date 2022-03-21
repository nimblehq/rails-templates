# frozen_string_literal: true

RSpec.configure do |config|
  config.when_first_matching_example_defined(type: :system) do
    # On CI we use Docker and the assets are precompiled (in the Dockerfile) already
    # On local, usually we run the test on the host machine so have to precompile the assets before running the test
    `bundle exec rails assets:precompile RAILS_ENV=test NODE_ENV=test` unless ENV['CI']
  end
end
