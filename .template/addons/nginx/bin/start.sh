insert_into_file 'bin/start.sh', after: "fi\n" do
  <<-EOT

./bin/inject_port_into_nginx.sh

nginx -c /etc/nginx/conf.d/default.conf
  EOT
end

gsub_file('bin/start.sh', 'bundle exec rails s -p $PORT -b 0.0.0.0', 'bundle exec rails s -p 3000 -b 0.0.0.0')
