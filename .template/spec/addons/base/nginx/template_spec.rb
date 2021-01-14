describe 'Nginx addon - template' do
  it 'starts nginx in start.sh' do
    expect(file('bin/start.sh')).to contain('nginx -c /etc/nginx/conf.d/default.conf')
  end
  
  it 'sets the HEROKU $PORT as Nginx HTTP listener' do
    expect(file('bin/start.sh')).to contain(/'sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf/')
  end
  
  it 'starts the Puma under PORT 3000' do
    expect(file('bin/start.sh')).to contain('bundle exec rails s -p 3000 -b 0.0.0.0')
  end
  
  it 'adjusts Dockerfile to work with Nginx' do
    expect(file('Dockerfile')).to contain('nginx').after('unzip')
    expect(file('Dockerfile')).to contain('PORT=3000')
    expect(file('Dockerfile')).to contain('COPY config/nginx/app.conf.template /etc/nginx/conf.d/default.conf')
  end
end
