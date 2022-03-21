# frozen_string_literal: true

gsub_file(
  'config/environments/production.rb',
  /config.public_file_server.enabled.*/,
  'config.public_file_server.enabled = false'
)
