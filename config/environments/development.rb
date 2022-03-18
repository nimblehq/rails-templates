insert_into_file 'config/environments/development.rb', after: /config.action_mailer.perform_caching.+\n/ do
  <<~RUBY.indent(2)

    config.action_mailer.delivery_method = :letter_opener

    config.action_mailer.asset_host = ENV.fetch('MAILER_DEFAULT_HOST')

    config.action_mailer.default_url_options = {
      host: ENV.fetch('MAILER_DEFAULT_HOST'),
      port: ENV.fetch('MAILER_DEFAULT_PORT')
    }
  RUBY
end

insert_into_file 'config/environments/development.rb', before: /^end/ do
  <<~RUBY.indent(2)

    # Configure Bullet gem to detect N+1 queries
    config.after_initialize do
      Bullet.enable        = true
      Bullet.bullet_logger = true
      Bullet.console       = true
      Bullet.rails_logger  = true
      Bullet.add_footer    = true
    end
  RUBY
end
