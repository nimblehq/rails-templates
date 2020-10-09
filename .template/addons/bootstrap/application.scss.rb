# frozen_string_literal: true

insert_into_file 'app/assets/stylesheets/application.scss', after: /@import 'variables'.+\n/ do
  <<~SCSS
    // Dependencies
    @import 'vendor/bootstrap/bootstrap';
  SCSS
end
