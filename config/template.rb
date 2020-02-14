# Setup config
apply 'config/application.rb'

template 'config/application.yml.tt'
copy_file 'config/database.yml', force: true
copy_file 'config/sidekiq.yml'
copy_file 'config/i18n-js.yml'

apply 'config/environments/development.rb'
apply 'config/environments/production.rb'
apply 'config/environments/test.rb'
