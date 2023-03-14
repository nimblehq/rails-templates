# frozen_string_literal: true

RSpec.configure do |config|
  config.when_first_matching_example_defined(type: :system) do
    # On CI we use Docker and the assets are precompiled (in the Dockerfile) already
    # On local, usually we run the test on the host machine so have to precompile the assets before running the test
    precompile_assets unless ENV['CI']
  end

  config.when_first_matching_example_defined(type: :request) do
    # On CI we use Docker and the assets are precompiled (in the Dockerfile) already
    # On local, usually we run the test on the host machine so have to precompile the assets before running the test
    precompile_assets unless ENV['CI']
  end
end

private

def precompile_assets
  `bundle exec rails assets:precompile RAILS_ENV=test NODE_ENV=test`
end
