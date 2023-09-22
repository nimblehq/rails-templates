# frozen_string_literal: true

apply '.template/addons/hotwire/Gemfile.rb'
apply '.template/addons/hotwire/package.json.rb'
apply '.template/addons/hotwire/.eslintrc.rb'

directory '.template/addons/hotwire/spec/javascript/controllers',
          'spec/javascript/controllers'
