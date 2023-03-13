# frozen_string_literal: true

module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end

RSpec.configure do |config|
  config.include Request::JsonHelpers, type: :request
end
