insert_into_file 'bin/start.sh', after: "fi\n" do
  <<-EOT

nginx -c /etc/nginx/conf.d/default.conf

  EOT
end
