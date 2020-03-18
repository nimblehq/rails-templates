describe 'config/application.rb' do
  subject { file('config/application.rb') }

  it 'configures the active job queue adapter to Sidekiq' do
    expect(subject).to contain('config.active_job.queue_adapter = :sidekiq')
  end

  it 'configures the active job queue name prefix to its environment' do
    expect(subject).to contain('config.active_job.queue_name_prefix = Rails.env')
  end

  it 'configures the middleware for rack deflater' do
    expect(subject).to contain('config.middleware.use Rack::Deflater')
  end

  it 'configures the autoload paths' do
    expect(subject).to contain("config.autoload_paths << Rails.root.join('lib')")
  end

  it 'configures the eager load paths' do
    expect(subject).to contain("config.eager_load_paths << Rails.root.join('lib')")
  end
end
