RSpec.configure do |config|
  config.when_first_matching_example_defined(type: :system) do
    if ENV['TEST_SKIP_ASSET'].blank?
      puts 'Prepare webpack assets for test environment'

      `RAILS_ENV=test NODE_ENV=test bin/webpack`
    end
  end
end
