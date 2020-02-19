insert_into_file 'spec/codebase/codebase_spec.rb', before: %r{end\Z} do
  <<-EOT

  it 'does not offend scss-lint' do
    expect(`scss-lint`).to be_empty
  end

  it 'does not offend eslint' do
    expect(`yarn run eslint ./`).to include 'Done'
  end
  EOT
end
