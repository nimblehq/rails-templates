# frozen_string_literal: true

describe 'Nginx addon - template' do
  it 'creates the inject_port_into_nginx script' do
    expect(file('bin/inject_port_into_nginx.sh')).to exist
    expect(file('bin/inject_port_into_nginx.sh')).to be_executable
  end

  it 'sets the $PORT as Nginx HTTP listener' do
    expect(file('bin/start.sh')).to contain('./bin/inject_port_into_nginx.sh')
  end

  it 'starts nginx in start.sh' do
    expect(file('bin/start.sh')).to contain('nginx -c /etc/nginx/conf.d/default.conf')
  end

  it 'starts the Puma under PORT 3000' do
    expect(file('bin/start.sh')).to contain('bundle exec rails s -p 3000 -b 0.0.0.0')
  end

  it 'adjusts Dockerfile to work with Nginx' do
    expect(file('Dockerfile')).to contain('nginx').after('unzip')
    expect(file('Dockerfile')).to contain('PORT=3000')
    expect(file('Dockerfile')).to contain('COPY config/nginx/app.conf.template /etc/nginx/conf.d/default.conf')
  end

  it 'disables Rails serve static file' do
    expect(file('config/environments/production.rb')).to contain('config.public_file_server.enabled = false')
  end
end
