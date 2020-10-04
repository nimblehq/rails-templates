insert_into_file 'app/assets/stylesheets/application.scss', after: /@import 'variables'.+\n/ do
  <<~EOT

    @import 'bootstrap/bootstrap';
  EOT
end
