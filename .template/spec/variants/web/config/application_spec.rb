# frozen_string_literal: true

describe 'Web variant - config/application.rb' do
  subject { file('config/application.rb') }

  it 'configures the middleware for I18n-js' do
    expect(subject).to contain('config.middleware.use I18n::JS::Middleware')
  end
end
