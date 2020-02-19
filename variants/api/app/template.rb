# Controllers
directory 'app/controllers/concerns'
inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
  <<-EOT
  include Localization
  EOT
end
