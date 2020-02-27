module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end

RSpec.configure do |config|
  config.include RSpec::Rails::ControllerExampleGroup, type: :request # required to have access to routes block
  config.include Request::JsonHelpers, type: :request
end
