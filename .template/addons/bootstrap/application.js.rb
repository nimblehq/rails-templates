insert_into_file 'app/javascript/packs/application.js', after: %r{import 'core-js/stable'.+\n} do
  <<~EOT
    import 'vendor/bootstrap';
  EOT
end
