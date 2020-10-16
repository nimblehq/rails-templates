use_source_path __dir__

if WEB_VARIANT
  apply 'config/environments/production.rb'
  
  template 'config/nginx/web/app.conf.template.tt', 'config/nginx/app.conf.template'
else
  template 'config/nginx/api/app.conf.template.tt', 'config/nginx/app.conf.template'
end
