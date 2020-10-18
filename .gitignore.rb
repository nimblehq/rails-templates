append_to_file '.gitignore' do
  <<~EOT

      # Ignore i18n.js generated files
      # If deploy to heroku with git, please remove this as it prevents the files to be committed
      /app/javascript/translations/translations.js

      # Ignore folder information and IDE-specific files
      .DS_Store
      .idea/*

      # Ignore the test coverage results from SimpleCov
      /coverage

      # Terraform generated files
      /deploy/.terraform/
      /deploy/terraform.tfstate
      /deploy/terraform.tfstate.backup
  EOT
end
