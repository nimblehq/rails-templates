gsub_file(
  'config/environments/production.rb',
  "config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?",
  'config.public_file_server.enabled = false',
)

gsub_file(
  'config/environments/production.rb',
  "config.public_file_server.enabled = true",
  'config.public_file_server.enabled = false',
)
