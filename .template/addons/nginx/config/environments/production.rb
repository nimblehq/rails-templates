gsub_file(
  'config/environments/production.rb',
  %r{config.public_file_server.enabled.*},
  'config.public_file_server.enabled = false',
)
