# Javascript
directory 'app/javascript'

if File.exist?('app/views/layouts/application.html.erb')
  insert_into_file 'app/views/layouts/application.html.erb', before: %r{</head>} do
    <<~ERB.indent(2)
      <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
    ERB
  end
else
  @template_errors.add <<~ERROR
    Cannot include javascript into `app/views/layouts/application.html.erb`
    Content: <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
  ERROR
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
  <<~RUBY.indent(2)
    include Localization
  RUBY
end

if File.exist?('app/views/layouts/application.html.erb')
  gsub_file 'app/views/layouts/application.html.erb', /<html>/ do
    "<html lang='<%= I18n.locale %>'>"
  end
else
  @template_errors.add <<~ERROR
    Cannot insert the lang attribute into html tag into `app/views/layouts/application.html.erb`
    Content: <html lang='<%= I18n.locale %>'>
  ERROR
end
