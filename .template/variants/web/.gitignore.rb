# frozen_string_literal: true

append_to_file '.gitignore' do
  <<~IGNORE
    # Ignore i18n.js generated files
    # If deploy to heroku with git, please remove this as it prevents the files to be committed
    /app/javascript/translations/*

    # Ignore asset builds
    /app/assets/builds/*

    # Ignore Node dependencies
    /node_modules
  IGNORE
end
