append_to_file 'Procfile.dev' do
  <<~PROCFILE
    js: yarn build --watch
    css: yarn build:css --watch
  PROCFILE
end
