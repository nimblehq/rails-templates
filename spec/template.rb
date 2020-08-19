generate 'rspec:install'

directory 'spec', exclude_pattern: 'template.rb', force: true

copy_file '.rspec', force: true
