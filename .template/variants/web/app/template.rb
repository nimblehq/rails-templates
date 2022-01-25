# Javascript
directory 'app/javascript'

if File.exist?('app/views/layouts/application.html.erb')
  insert_into_file 'app/views/layouts/application.html.erb', before: %r{</head>} do
    <<~EOT.indent(2)
      <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
    EOT
  end
else
  @template_errors.add <<~EOT
    Cannot include javascript into `app/views/layouts/application.html.erb`
    Content: <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
  EOT
end

# Stylesheets
remove_file 'app/assets/stylesheets/application.css'
directory 'app/assets/stylesheets'

run 'yarn build:css'
gsub_file 'app/assets/config/manifest.js', "//= link_directory ../stylesheets .css\n", ''
append_to_file 'app/assets/config/manifest.js', '//= link_tree ../builds'

# I18n
directory 'app/controllers/concerns'
inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
  <<~EOT.indent(2)
    include Localization
  EOT
end

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
