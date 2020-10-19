use_source_path __dir__

apply 'config/environments/production.rb' if WEB_VARIANT

template 'config/nginx/app.conf.template.tt'
