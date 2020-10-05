# frozen_string_literal: true

insert_into_file 'package.json', after: /"i18n-js":.+\n/ do
  <<~JSON
    "bootstrap.native": "3.0.13",
  JSON
end
