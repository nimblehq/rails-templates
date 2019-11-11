def setup_rails_i18n
  inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
    "  include Localization\n"
  end
end

def setup_i18n_js
  environment(nil, env: 'development') do
    <<~EOT
      # Automatically generate the `translation.js` files
      config.middleware.use I18n::JS::Middleware

    EOT
  end

  gsub_file 'app/views/layouts/application.html.erb', /<html>/ do
    "<html lang='<%= I18n.locale %>'>"
  end

  append_to_file '.gitignore' do
    <<~EOT

      # Ignore i18n.js generated files
      # If deploy to heroku with git, please remove this as it prevents the files to be committed
      /app/javascript/translations/translations.js
    EOT
  end
end

