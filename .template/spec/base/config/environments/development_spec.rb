describe 'config/environments/development.rb' do
  subject { file('config/environments/development.rb') }

  it 'configures the mailer delivery method to use letter opener' do
    expect(subject).to contain('config.action_mailer.delivery_method = :letter_opener')
  end

  it 'configures the mailer asset host' do
    expect(subject).to contain("config.action_mailer.asset_host = ENV.fetch('MAILER_DEFAULT_HOST')")
  end

  it 'configures the mailer default url options' do
    expect(subject).to contain(mailer_default_url_config)
  end

  it 'configures the Bullet gem' do
    expect(subject).to contain(bullet_config)
  end

  private

  def mailer_default_url_config
    <<~EOT
      config.action_mailer.default_url_options = {
        host: ENV.fetch('MAILER_DEFAULT_HOST'),
        port: ENV.fetch('MAILER_DEFAULT_PORT')
      }
    EOT
  end

  def bullet_config
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
end
