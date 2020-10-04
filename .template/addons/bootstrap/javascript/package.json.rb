insert_into_file 'package.json', after: /"i18n-js":.+\n/ do
  <<~EOT
    "bootstrap.native": "3.0.13",
  EOT
end
