def setup_bullet
  environment(nil, env: 'development') do
    <<~EOT
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

  environment(nil, env: 'test') do
    <<~EOT
      # Configure Bullet gem to detect N+1 queries
      config.after_initialize do
        Bullet.enable                      = true
        Bullet.bullet_logger               = true
        Bullet.raise                       = true
        Bullet.unused_eager_loading_enable = false
      end

    EOT
  end
end
