describe 'config/environments/production.rb' do
  subject { file('config/environments/production.rb') }

  it 'configures the mailer asset host' do
    expect(subject).to contain("config.action_mailer.asset_host = ENV.fetch('MAILER_DEFAULT_HOST')")
  end

  it 'configures the mailer default url options' do
    expect(subject).to contain(mailer_default_url_config)
  end

  it 'allow Rails serve static file' do
    expect(subject).to contain('config.public_file_server.enabled = true')
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
end
