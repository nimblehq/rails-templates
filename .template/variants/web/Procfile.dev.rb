# frozen_string_literal: true

append_to_file 'Procfile.dev' do
  <<~PROCFILE
    js: yarn build --watch
    css: yarn build:css --watch
    postcss: yarn build:postcss --watch
  PROCFILE
end
