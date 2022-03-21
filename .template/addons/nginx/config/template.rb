# frozen_string_literal: true

use_source_path __dir__

apply 'config/environments/production.rb'

template 'config/nginx/app.conf.template.tt'
