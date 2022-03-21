# frozen_string_literal: true

require 'rspec/retry'

RSpec.configure do |config|
  # show retry status in spec process
  config.verbose_retry = true
  # show exception that triggers a retry if verbose_retry is set to true
  config.display_try_failure_messages = true

  # run retry only on system tests
  config.around :each, type: :system do |example|
    example.run_with_retry retry: ENV.fetch('TEST_RETRY').to_i
  end
end
