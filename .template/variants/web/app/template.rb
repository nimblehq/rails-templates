# Javascript
directory 'app/javascript'

if File.exist?('app/javascript/application.js')
  append_to_file 'app/javascript/application.js' do
    <<~EOT
      import './translations/translations';

      import './initializers/';
      import './screens/';
    EOT
  end
else
  @template_errors.add <<~EOT
    Cannot import the dependencies to `app/javascript/application.js`
    Content: import './translations/translations';

             import './initializers/';
             import './screens/';
  EOT
end

# Stylesheets
remove_file 'app/assets/stylesheets/application.css'
directory 'app/assets/stylesheets'

run 'yarn build:css'
gsub_file 'app/assets/config/manifest.js', "//= link_directory ../stylesheets .css\n", ''
append_to_file 'app/assets/config/manifest.js', '//= link_tree ../builds'

# Controllers
directory 'app/controllers/concerns'
inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
  <<~EOT.indent(2)
    include Localization
  EOT
end

# Views
if File.exist?('app/views/layouts/application.html.erb')
  gsub_file 'app/views/layouts/application.html.erb', /<html>/ do
    "<html lang='<%= I18n.locale %>'>"
  end

  insert_into_file 'app/views/layouts/application.html.erb', before: %r{</head>} do
    <<~EOT.indent(2)
      <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
    EOT
  end
else
  @template_errors.add <<~EOT
    Cannot insert the lang attribute into html tag into `app/views/layouts/application.html.erb`
    Content: <html lang='<%= I18n.locale %>'>
             <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
  EOT
end
