generate 'rspec:install'

directory 'spec', force: true
FileUtils.rm('spec/template.rb')

copy_file '.rspec', force: true
