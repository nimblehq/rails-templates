def setup_rspec
  generate "rspec:install"
  remove_file ".rspec"
  copy_file 'shared/rspec/.rspec', '.rspec'

  FileUtils.cp_r "#{current_directory}/shared/rspec/.", 'spec/'
  run 'rm -rf spec/.rspec' # remove the .rspec file from rspec folder

  # folder for rspec
  run 'mkdir spec/codebase'
  run 'mkdir spec/fabricators'
  run 'mkdir spec/system'
  run 'mkdir spec/requests'
  run 'mkdir spec/support'
end
