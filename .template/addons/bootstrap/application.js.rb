# frozen_string_literal: true

insert_into_file 'app/javascript/packs/application.js', after: %r{import 'core-js/stable'.+\n} do
  <<~JAVASCRIPT
    import 'vendor/bootstrap';
  JAVASCRIPT
end
