# frozen_string_literal: true

apply 'config/application.rb'

template 'config/application.yml.tt'
copy_file 'config/database.yml', force: true
copy_file 'config/sidekiq.yml'
copy_file 'config/rails_best_practices.yml'

apply 'config/environments/development.rb'
apply 'config/environments/production.rb'
apply 'config/environments/test.rb'

copy_file 'config/initializers/backtrace_silencers.rb'
