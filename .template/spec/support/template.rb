# Explicitly require the lib module for testing
Dir.glob(File.expand_path('../../lib/template/**/*.rb', __dir__)).sort.each { |f| require f }

module TemplateApplicationHelpers
  def template_application
    @template_application ||= Template::Application.new
  end
end

RSpec.configure do |config|
  config.include TemplateApplicationHelpers
end
