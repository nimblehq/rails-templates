# frozen_string_literal: true

insert_into_file 'app/javascript/application.js', before: %r{import './translations/translations'.+\n} do
  <<~JAVASCRIPT
    import './vendor/';
  JAVASCRIPT
end
