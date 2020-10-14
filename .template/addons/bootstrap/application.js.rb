# frozen_string_literal: true

insert_into_file 'app/javascript/packs/application.js', before: %r{import 'translations/translations'.+\n} do
  <<~JAVASCRIPT
    import 'vendor/bootstrap';
  JAVASCRIPT
end
