append_to_file 'Procfile.dev' do
  <<~EOT
    js: yarn build --watch
    css: yarn build:css --watch
  EOT
end
