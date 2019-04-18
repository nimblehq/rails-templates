def setup_i18n_js
  environment(nil, env: 'development') do
    <<~EOT
      # Automatically generate the `translation.js` files
      config.middleware.use I18n::JS::Middleware

    EOT
  end

  insert_into_file 'app/assets/javascripts/application.js', after: "//= require activestorage\n" do
    <<~EOT
      //= require i18n
      //= require translations/translations
    EOT
  end

  append_to_file '.gitignore' do
    <<~EOT
      
      # Ignore i18n.js generated files
      # If deploy to heroku with git, please remove this as it prevents the files to be committed
      /vendor/assets/javascripts/i18n.js
      /app/assets/javascripts/translations/translations.js
    EOT
  end
end

