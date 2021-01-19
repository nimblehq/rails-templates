use_source_path __dir__

apply 'start.sh'
copy_file 'bin/inject_port_into_nginx.sh', mode: :preserve
