after_bundle do
  use_source_path __dir__

  empty_directory "deploy"

  directory ".template/addons/terraform/heroku", "deploy",
    :exclude_pattern => /(\/template.rb$)|(\/heroku.yml$)/

  template "heroku.yml"
end
