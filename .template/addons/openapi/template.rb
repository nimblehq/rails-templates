# frozen_string_literal: true

use_source_path __dir__

directory 'docs'
apply '.gitignore.rb'
copy_file '.spectral.yml'
