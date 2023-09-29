# frozen_string_literal: true

use_source_path __dir__

directory 'docs'
directory '.github' if @install_github_action
apply '.gitignore.rb'
apply 'package.json.rb'
copy_file '.spectral.yml'
copy_file 'public/openapi.html'

after_bundle do
  run 'yarn build:docs'
end
