insert_into_file 'config/application.rb', before: %r{end\nend\Z} do
  <<-EOT

    # Automatically generate the `translation.js` files
    config.middleware.use I18n::JS::Middleware
  EOT
end
