# frozen_string_literal: true

use_source_path __dir__

remove_file 'app/views/layouts/application.html.erb'
directory 'app/views/layouts/application'
template 'app/views/layouts/application.html.slim.tt'

# SCSS Layout
directory 'app/assets/stylesheets/layouts'
insert_into_file 'app/assets/stylesheets/application.scss', after: %r{// Layouts\n} do
  <<~SCSS
    @import 'layouts';
  SCSS
end
