# Javascript
directory 'app/javascript'

if File.exist?('app/javascript/packs/application.js')
  insert_into_file 'app/javascript/packs/application.js', after: %r{import "channels"\n} do
    <<~EOT

      import 'core-js/stable';
      import 'regenerator-runtime/runtime';

      import 'translations/translations';

      import 'initializers/';
      import 'screens/';
    EOT
  end
else
  @template_errors.add <<~EOT
    Cannot import the dependencies to `app/javascript/packs/application.js`
    Content: import 'core-js/stable';
             import 'regenerator-runtime/runtime';
             
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
if File.exist?('app/views/layouts/application.html.erb')
  gsub_file 'app/views/layouts/application.html.erb', /<html>/ do
    "<html lang='<%= I18n.locale %>'>"
  end
else
  @template_errors.add <<~EOT
    Cannot insert the lang attribute into html tag into `app/views/layouts/application.html.erb`
    Content: <html lang='<%= I18n.locale %>'>
  EOT
end
