describe 'Nginx addon - template' do
  it 'allows Rails serve static file' do
    expect(file('config/environments/production.rb')).to contain('config.public_file_server.enabled = true')
  end
  
  it 'creates config/nginx/app.conf.template file' do
    expect(file('config/nginx/app.conf.template')).not_to contain('gzip on;')
  end
end
