append_to_file 'Procfile.dev' do
  <<~EOT
    webpack: yarn && bin/webpack-dev-server
    css: yarn build:css --watch
  EOT
end
