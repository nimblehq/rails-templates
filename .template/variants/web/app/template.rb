# frozen_string_literal: true

# Javascript
directory 'app/javascript'

erb_layout_file = 'app/views/layouts/application.html.erb'
slim_layout_file = 'app/views/layouts/application.html.slim'
layout_file = nil

layout_file = erb_layout_file if File.exist?(erb_layout_file)
layout_file = slim_layout_file if File.exist?(slim_layout_file)

if layout_file
  insert_into_file layout_file, before: %r{</head>} do
    <<~ERB.indent(2)
      <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
    ERB
  end
else
  @template_errors.add <<~ERROR
    Cannot include javascript into `app/views/layouts/application.html.{erb|slim}`
    Content: <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
  ERROR
end

# Stylesheets
remove_file 'app/assets/stylesheets/application.css'
directory 'app/assets/stylesheets'
directory 'app/assets/builds'

run 'yarn build:css-dev'
gsub_file 'app/assets/config/manifest.js', "//= link_directory ../stylesheets .css\n", ''
append_to_file 'app/assets/config/manifest.js', '//= link_tree ../builds'

# I18n
directory 'app/controllers/concerns'
inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
  <<~RUBY.indent(2)
    include Localization
  RUBY
end

if erb_layout_file
  gsub_file 'app/views/layouts/application.html.erb', /<html>/ do
    "<html lang='<%= I18n.locale %>'>"
  end
# The slim layout (CRUD addon) already has the lang attribute
elsif slim_layout_file.blank?
  @template_errors.add <<~ERROR
    Cannot insert the lang attribute into html tag into `app/views/layouts/application.html.erb`
    Content: <html lang='<%= I18n.locale %>'>
  ERROR
end
