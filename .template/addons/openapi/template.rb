# frozen_string_literal: true

use_source_path __dir__

directory 'docs'
directory '.github' if @install_github_action
apply '.gitignore.rb'
apply 'package.json.rb'
copy_file '.spectral.yml'
copy_file 'public/openapi.html'

if yes?(install_addon_prompt('Mock Server'))
  @install_mock_server = true
  copy_file 'fly.toml'
  copy_file 'Dockerfile.mock'
end

after_bundle do
  run 'yarn build:docs'
end
