describe '/config template' do
  it 'creates the Figaro configuration for application variables' do
    expect(file('config/application.yml')).to exist
  end

  it 'creates the database configuration' do
    expect(file('config/database.yml')).to exist
  end

  it 'creates the Sidekiq configuration' do
    expect(file('config/sidekiq.yml')).to exist
  end

  it 'creates the Rails Best Practices configuration' do
    expect(file('config/rails_best_practices.yml')).to exist
  end
end
