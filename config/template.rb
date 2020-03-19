apply 'config/application.rb'

template 'config/application.yml.tt'
copy_file 'config/database.yml', force: true
copy_file 'config/sidekiq.yml'

apply 'config/environment.rb'
apply 'config/environments/development.rb'
apply 'config/environments/production.rb'
apply 'config/environments/test.rb'
