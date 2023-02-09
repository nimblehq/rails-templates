# frozen_string_literal: true

describe 'Web variant - config/environments/test.rb' do
  subject { file('config/environments/test.rb') }

  it 'requires the disable animation support file' do
    expect(subject).to contain("require_relative '../../spec/support/disable_animation'")
  end

  it 'configures the middleware to disable the animations' do
    expect(subject).to contain('config.middleware.use Rack::NoAnimations')
  end

  it 'configures the assets to not compile when asset is missing' do
    expect(subject).to contain('config.assets.compile = false')
  end

  it 'eager load on CI' do
    expect(subject).to contain('config.eager_load = ENV[\'C\'].present?')
  end
end
