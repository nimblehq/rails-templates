describe 'Nginx addon - template' do
  it 'disables Rails serve static file' do
    expect(file('config/environments/production.rb')).to contain('config.public_file_server.enabled = false')
  end
  
  it 'creates config/nginx/app.conf.template file' do
    expect(file('config/nginx/app.conf.template')).to contain('gzip on;')
  end
end
