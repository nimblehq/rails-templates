insert_into_file 'package.json', after: %r{"private":.+\n} do
  <<~EOT
    "scripts": {
      "lint": "eslint . --color",
      "lint:fix": "eslint . --color --fix"
    },
  EOT
end

insert_into_file 'package.json', after: %r{"@rails/ujs":.+\n} do
  <<~EOT
    "i18n-js": "^3.0.11",
  EOT
end

insert_into_file 'package.json', before: %r{"version":.+\n} do
  <<~EOT
      "devDependencies": {
        "@nimbl3/eslint-config-nimbl3": "2.1.1"
      },
  EOT
end
