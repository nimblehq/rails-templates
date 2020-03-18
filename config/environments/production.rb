insert_into_file 'config/environments/production.rb', after: %r{config.action_mailer.perform_caching.+\n} do
  <<-EOT

  config.action_mailer.asset_host = #{@template_application.namespace}::Env.fetch('MAILER_DEFAULT_HOST')

  config.action_mailer.default_url_options = { 
    host: #{@template_application.namespace}::Env.fetch('MAILER_DEFAULT_HOST'), 
    port: #{@template_application.namespace}::Env.fetch('MAILER_DEFAULT_PORT')
  }
  EOT
end
