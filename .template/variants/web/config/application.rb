insert_into_file 'config/application.rb', before: /  end\nend\Z/ do
  <<~RUBY.indent(4)

    # Automatically generate the `translation.js` files
    config.middleware.use I18n::JS::Middleware
  RUBY
end
