# frozen_string_literal: true

copy_file 'bin/envsetup.sh', mode: :preserve
copy_file 'bin/envteardown.sh', mode: :preserve
copy_file 'bin/start.sh', mode: :preserve
copy_file 'bin/test.sh', mode: :preserve
copy_file 'bin/worker.sh', mode: :preserve
copy_file 'bin/docker-prepare', mode: :preserve

if WEB_VARIANT
copy_file 'bin/docker-assets-precompile', mode: :preserve
end
