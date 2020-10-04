use_source_path __dir__

apply '.template/addons/bootstrap/stylesheets/application.scss.rb'
apply '.template/addons/bootstrap/javascript/package.json.rb'
apply '.template/addons/bootstrap/javascript/application.js.rb'

directory('stylesheets/bootstrap', 'vendor/assets/stylesheets/bootstrap')
directory('javascript/bootstrap', 'app/javascript/vendor/bootstrap')
