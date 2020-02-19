PRODUCTION_CONFIG = 'config/environments/production.rb'

insert_into_file PRODUCTION_CONFIG, after: %r{config.action_mailer.perform_caching.+\n} do
  <<-EOT

  config.action_mailer.asset_host = ENV.fetch('MAILER_DEFAULT_HOST')

  config.action_mailer.default_url_options = { 
    host: ENV.fetch('MAILER_DEFAULT_HOST'), 
    port: ENV.fetch('MAILER_DEFAULT_PORT')
  }
  EOT
end
