# frozen_string_literal: true

describe '/config template' do
  it 'does NOT create the application.yml config' do
    expect(file('config/application.yml')).not_to exist
  end

  it 'creates the database configuration' do
    expect(file('config/database.yml')).to exist
  end

  it 'creates the Sidekiq configuration' do
    expect(file('config/sidekiq.yml')).to exist
  end

  it 'creates the backtrace silencer initializer' do
    expect(file('config/initializers/backtrace_silencers.rb')).to exist
  end
end
