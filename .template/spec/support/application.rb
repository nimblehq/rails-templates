require File.expand_path('../../lib/template/application', __dir__)

RSpec.configure do |_config|
  template_application = Template::Application.new

  APP_NAME = template_application.app_name
  APP_NAME_HUMANIZED = template_application.humanized_name
  APP_DIRECTORY_NAME = template_application.directory_name
  APP_NAMESPACE = template_application.namespace
end
