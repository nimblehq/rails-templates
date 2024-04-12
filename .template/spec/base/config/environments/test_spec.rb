# frozen_string_literal: true

describe 'config/environments/test.rb' do
  subject { file('config/environments/test.rb') }

  it 'configures the mailer default url options' do
    expect(subject).to contain(mailer_default_url_config)
  end

  it 'configures the Bullet gem' do
    expect(subject).to contain(bullet_config)
  end

  it 'eager load on CI' do
    expect(subject).to contain('config.eager_load = ENV["CI"].present?')
  end

  private

  def mailer_default_url_config
    <<~RUBY
      config.action_mailer.default_url_options = {
        host: ENV.fetch('MAILER_DEFAULT_HOST', 'localhost'),
        port: ENV.fetch('MAILER_DEFAULT_PORT')
      }
    RUBY
  end

  def bullet_config
    <<~RUBY
      # Configure Bullet gem to detect N+1 queries
      config.after_initialize do
        Bullet.enable                      = true
        Bullet.bullet_logger               = true
        Bullet.raise                       = true
        Bullet.unused_eager_loading_enable = false
      end
    RUBY
  end
end
