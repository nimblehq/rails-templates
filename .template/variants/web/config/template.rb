# frozen_string_literal: true

apply 'config/application.rb'

copy_file 'config/i18n-js.yml'

apply 'config/environments/test.rb'
apply 'config/initializers/assets.rb'
