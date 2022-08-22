# frozen_string_literal: true

after_bundle do
  use_source_path __dir__

  copy_file '.phrase.yml'
  apply 'spec/template.rb'
end
