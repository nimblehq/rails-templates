# frozen_string_literal: true

describe 'Semaphore addon - template' do
  it 'creates the Dockerfile.web' do
    expect(file('Dockerfile.web')).to exist
  end

  it 'creates the Dockerfile.worker' do
    expect(file('Dockerfile.worker')).to exist
  end
end
