# frozen_string_literal: true

use_source_path __dir__

apply '.template/addons/bootstrap/application.scss.rb'
apply '.template/addons/bootstrap/package.json.rb'
apply '.template/addons/bootstrap/application.js.rb'

directory('stylesheets/vendor', 'app/assets/stylesheets/vendor')
directory('javascript/vendor', 'app/javascript/vendor')
