RSpec.configure do |config|
  config.before(:suite) do
    if ENV['TEST_SKIP_ASSET'].blank?
      puts 'Prepare webpack assets for test environment'

      `RAILS_ENV=test NODE_ENV=test bin/webpack`
    end
  end
end
