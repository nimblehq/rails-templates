after_bundle do
  use_source_path __dir__

  empty_directory "deploy"

  directory ".template/addons/terraform/eks", "deploy", recursive: true,
    :exclude_pattern => /\/template.rb$/
end
