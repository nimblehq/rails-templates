def setup_i18n_js
  environment(nil, env: "development") do
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
end

