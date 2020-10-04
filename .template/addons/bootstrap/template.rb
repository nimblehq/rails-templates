use_source_path __dir__

apply '.template/addons/bootstrap/application.scss.rb'
apply '.template/addons/bootstrap/package.json.rb'
apply '.template/addons/bootstrap/application.js.rb'

directory('stylesheets/bootstrap', 'vendor/assets/stylesheets/bootstrap')
directory('javascript/bootstrap', 'app/javascript/vendor/bootstrap')
