# frozen_string_literal: true

insert_into_file 'app/javascript/packs/application.js', after: %r{import "channels"\n} do
  <<~JAVASCRIPT

    import 'vendor/bootstrap';
  JAVASCRIPT
end
