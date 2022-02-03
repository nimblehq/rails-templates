describe 'config/environments/production.rb' do
  subject { file('config/environments/production.rb') }

  it 'configures the mailer asset host' do
    expect(subject).to contain("config.action_mailer.asset_host = ENV.fetch('MAILER_DEFAULT_HOST')")
  end

  it 'configures the mailer default url options' do
    expect(subject).to contain(mailer_default_url_config)
  end

  it 'adds the i18n configuration' do
    expect(subject).to contain(i18n_config)
  end

  it 'removes the config.i18n.fallbacks = true' do
    expect(subject).not_to contain('config.i18n.fallbacks = true')
  end

  private

  def mailer_default_url_config
    <<~RUBY
      config.action_mailer.default_url_options = {
        host: ENV.fetch('MAILER_DEFAULT_HOST'),
        port: ENV.fetch('MAILER_DEFAULT_PORT')
      }
    RUBY
  end

  def i18n_config
    <<~RUBY
      # eg: AVAILABLE_LOCALES = 'en,th'
      config.i18n.available_locales = ENV.fetch('AVAILABLE_LOCALES').split(',')

      # eg: DEFAULT_LOCALE = 'en'
      config.i18n.default_locale = ENV.fetch('DEFAULT_LOCALE')

      # eg: FALLBACK_LOCALES = 'en,th'
      config.i18n.fallbacks = ENV.fetch('FALLBACK_LOCALES').split(',')
    RUBY
  end
end
