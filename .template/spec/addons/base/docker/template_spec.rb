describe 'Docker addon - template' do
  it 'creates the Dockerfile' do
    expect(file('Dockerfile')).to exist
  end

  it 'creates the docker env file' do
    expect(file('.env')).to exist
  end

  it 'creates the docker ignore file' do
    expect(file('.dockerignore')).to exist
  end

  it 'does not add the docker compose file' do
    expect(file('docker-compose.yml')).not_to exist
    expect(file('docker-compose.dev.yml')).not_to exist
    expect(file('docker-compose.test.yml')).not_to exist
  end
end
