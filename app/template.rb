# Javascript
directory 'app/javascript'

insert_into_file 'app/javascript/packs/application.js', after: %r{require\("channels"\)\n} do
  <<~EOT
  
    import 'translations/translations';
    
    import 'initializers/';
    import 'screens/';
  EOT
end

# Stylesheets
remove_file 'app/assets/stylesheets/application.css'
directory 'app/assets/stylesheets'

# Controllers
directory 'app/controllers/concerns'
inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
  <<-EOT
  include Localization
  EOT
end

# Views
gsub_file 'app/views/layouts/application.html.erb', /<html>/ do
  "<html lang='<%= I18n.locale %>'>"
end
