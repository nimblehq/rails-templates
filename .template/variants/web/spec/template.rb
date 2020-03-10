apply 'spec/codebase/codebase_spec.rb'

copy_file 'spec/support/assets.rb'
copy_file 'spec/support/capybara.rb'
copy_file 'spec/support/disable_animation.rb'
copy_file 'spec/support/system.rb'
copy_file 'spec/support/webdrivers.rb'

directory 'spec/systems'
