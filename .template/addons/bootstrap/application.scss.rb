# frozen_string_literal: true

insert_into_file 'app/assets/stylesheets/application.scss', after: %r{// Dependencies\n} do
  <<~SCSS
    @import './vendor';
  SCSS
end
