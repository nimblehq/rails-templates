DEVELOPMENT_CONFIG = 'config/environments/development.rb'

insert_into_file DEVELOPMENT_CONFIG, after: %r{config.action_mailer.perform_caching.+\n} do
  <<-EOT

  config.action_mailer.delivery_method = :letter_opener

  config.action_mailer.asset_host = ENV.fetch('MAILER_DEFAULT_HOST')

  config.action_mailer.default_url_options = { 
    host: ENV.fetch('MAILER_DEFAULT_HOST'), 
    port: ENV.fetch('MAILER_DEFAULT_PORT')
  }
  EOT
end

insert_into_file DEVELOPMENT_CONFIG, before: %r{^end} do
  <<-EOT
  
  # Configure Bullet gem to detect N+1 queries
  config.after_initialize do
    Bullet.enable        = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    Bullet.rails_logger  = true
    Bullet.add_footer    = true
  end
  EOT
end
