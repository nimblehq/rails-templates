# frozen_string_literal: true

if Gem.loaded_specs.key?('rspec')
  generate 'rspec:install'

  directory 'spec', exclude_pattern: 'template.rb', force: true

  copy_file '.rspec', force: true

  # Engine prefix name validator
  if File.exist?('spec/codebase/codebase_spec.rb')
    gsub_file 'spec/codebase/codebase_spec.rb', /APP_NAME_HERE/ do
      app_name
    end
  else
    @template_errors.add <<~ERROR
      Cannot insert the app_name into `spec/codebase/codebase_spec.rb`
      Content: #{app_name}
    ERROR
  end
end
