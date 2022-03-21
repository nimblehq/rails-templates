# frozen_string_literal: true

describe 'Web variant - Docker image' do
  it 'installs yarn package' do
    expect(package('yarn')).to be_installed
  end

  it 'installs nodejs package' do
    expect(package('nodejs')).to be_installed
  end
end
