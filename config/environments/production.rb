# Allow Rails serve static file by default, this can be disable on Nginx addon
gsub_file('config/environments/production.rb', "ENV['RAILS_SERVE_STATIC_FILES'].present?", 'true')

insert_into_file 'config/environments/production.rb', after: %r{config.action_mailer.perform_caching.+\n} do
  <<-EOT

  config.action_mailer.asset_host = ENV.fetch('MAILER_DEFAULT_HOST')

  config.action_mailer.default_url_options = { 
    host: ENV.fetch('MAILER_DEFAULT_HOST'), 
    port: ENV.fetch('MAILER_DEFAULT_PORT')
  }
  EOT
end
