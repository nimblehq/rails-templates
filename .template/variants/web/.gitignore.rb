# frozen_string_literal: true

append_to_file '.gitignore' do
  <<~IGNORE
    # Ignore i18n.js generated files
    # If deploy to heroku with git, please remove this as it prevents the files to be committed
    /app/javascript/translations/*

    # Ignore asset builds
    /app/assets/builds/*
    !/app/assets/builds/.keep

    # Ignore Node dependencies
    /node_modules

    # debug
    yarn-debug.log*
    yarn-error.log*
    .yarn-integrity

    # Ignore Byebug history.
    .byebug_history

    # Ignore master keys for decrypting credentials and more.
    /config/credentials/*.key

    # Ignore Gemfile.lock file in engines.
    /engines/*/Gemfile.lock

    # Ignore asset builds
    /app/assets/builds/*
    !/app/assets/builds/.keep
  IGNORE
end
