# frozen_string_literal: true

describe 'Web variant - /config template' do
  it 'creates i18n-js configuration file' do
    expect(file('config/i18n-js.yml')).to exist
  end
end
