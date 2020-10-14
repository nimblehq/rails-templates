after_bundle do
  use_source_path __dir__
  
  copy_file '.phraseapp.yml'
  apply 'spec/template.rb'
end
