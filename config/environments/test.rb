TEST_CONFIG = 'config/environments/test.rb'

insert_into_file TEST_CONFIG, after: %r{config.action_mailer.perform_caching.+\n} do
  <<-EOT

  config.action_mailer.default_url_options = { 
    host: ENV.fetch('MAILER_DEFAULT_HOST'), 
    port: ENV.fetch('MAILER_DEFAULT_PORT')
  }
  EOT
end

insert_into_file TEST_CONFIG, before: %r{^end} do
  <<-EOT
  
  # Configure Bullet gem to detect N+1 queries
  config.after_initialize do
    Bullet.enable                      = true
    Bullet.bullet_logger               = true
    Bullet.raise                       = true
    Bullet.unused_eager_loading_enable = false
  end

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false
  EOT
end
