describe 'Nginx addon - template' do
  it 'creates config/nginx/app.conf.template file' do
    expect(file('config/nginx/app.conf.template')).not_to contain('gzip on;')
  end
end
