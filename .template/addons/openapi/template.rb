# frozen_string_literal: true

use_source_path __dir__

directory 'docs'
directory '.github' if @install_github_action
apply '.gitignore.rb'
apply 'package.json.rb'
copy_file '.spectral.yml'
copy_file 'public/stoplight.html'

after_bundle do
  run 'yarn build:docs'

  insert_into_file 'config/routes.rb', before: /^end/ do
    <<~RUBY.indent(2)

      get 'api/docs/openapi', to: redirect('/stoplight.html')
    RUBY
  end
end
