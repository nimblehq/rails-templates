describe 'Nginx addon - template' do
  it 'starts nginx in start.sh' do
    expect(file('bin/start.sh')).to contain('nginx -c /etc/nginx/conf.d/default.conf')
  end
  
  it 'adjusts Dockerfile to work with Nginx' do
    expect(file('Dockerfile')).to contain('nginx').after('unzip')
    expect(file('Dockerfile')).to contain('PORT=3000')
    expect(file('Dockerfile')).to contain('COPY config/nginx/app.conf.template /etc/nginx/conf.d/default.conf')
  end
end
