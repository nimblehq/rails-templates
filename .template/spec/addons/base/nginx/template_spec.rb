describe 'Nginx addon - template' do
  it 'creates config/nginx/app.conf.template file' do
    expect(file('config/nginx/app.conf.template')).to exist
  end
  
  it 'disables Rails serve static file' do
    expect(file('config/environments/production.rb')).to contain('config.public_file_server.enabled = false')
  end
  
  it 'starts nginx in start.sh' do
    expect(file('bin/start.sh')).to contain('nginx -c /etc/nginx/conf.d/default.conf')
  end
  
  it 'adjusts Dockerfile to work with Nginx' do
    expect(file('Dockerfile')).to contain('nginx').after('unzip')
    expect(file('Dockerfile')).to contain('PORT=3000')
    expect(file('Dockerfile')).to contain('COPY config/nginx/app.conf.template /etc/nginx/conf.d/default.conf')
  end
end
