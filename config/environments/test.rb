insert_into_file 'config/environments/test.rb', after: %r{config.action_mailer.perform_caching.+\n} do
  <<-EOT

  config.action_mailer.default_url_options = { 
    host: ENV.fetch('MAILER_DEFAULT_HOST'), 
    port: ENV.fetch('MAILER_DEFAULT_PORT')
  }
  EOT
end

insert_into_file 'config/environments/test.rb', before: %r{^end} do
  <<-EOT
  
  # Configure Bullet gem to detect N+1 queries
  config.after_initialize do
    Bullet.enable                      = true
    Bullet.bullet_logger               = true
    Bullet.raise                       = true
    Bullet.unused_eager_loading_enable = false
  end
  EOT
end
