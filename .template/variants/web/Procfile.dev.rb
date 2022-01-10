append_to_file 'Procfile.dev' do
  <<~EOT
    webpack: yarn && bin/webpack-dev-server
  EOT
end
