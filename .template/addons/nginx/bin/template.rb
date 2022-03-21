# frozen_string_literal: true

use_source_path __dir__

apply 'start.sh.rb'
copy_file 'bin/inject_port_into_nginx.sh', mode: :preserve
