append_to_file '.gitignore' do
  <<~EOT
      # Ignore i18n.js generated files
      # If deploy to heroku with git, please remove this as it prevents the files to be committed
      /app/javascript/translations/translations.js

      # Ignore asset builds
      /app/assets/builds/*

      # Ignore Node dependencies
      /node_modules
  EOT
end
