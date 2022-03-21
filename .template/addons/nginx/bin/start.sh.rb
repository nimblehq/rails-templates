# frozen_string_literal: true

insert_into_file 'bin/start.sh', after: "fi\n" do
  <<~SHELL

    ./bin/inject_port_into_nginx.sh

    nginx -c /etc/nginx/conf.d/default.conf
  SHELL
end

gsub_file('bin/start.sh', 'bundle exec rails s -p $PORT -b 0.0.0.0', 'bundle exec rails s -p 3000 -b 0.0.0.0')
