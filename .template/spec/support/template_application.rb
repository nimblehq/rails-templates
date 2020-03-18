require File.expand_path('../../lib/template/application', __dir__)

module TemplateApplicationHelpers
  def template_application
    @template_application ||= Template::Application.new
  end
end

RSpec.configure do |config|
  config.include TemplateApplicationHelpers
end
