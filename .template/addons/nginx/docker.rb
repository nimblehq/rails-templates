insert_into_file 'Dockerfile', after: 'unzip ' do
  'nginx '
end

insert_into_file 'Dockerfile', after: %r{WORKDIR.+\n} do
  <<~DOCKERFILE

    # Nginx config
    COPY config/nginx/app.conf.template /etc/nginx/conf.d/default.conf
  DOCKERFILE
end

gsub_file 'Dockerfile', /PORT=80/ do
  'PORT=3000'
end
