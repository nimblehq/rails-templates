insert_into_file 'spec/codebase/codebase_spec.rb', before: /end\Z/ do
  <<~RUBY.indent(2)

    it 'does not offend stylelint' do
      expect(`yarn run stylelint`).to include 'Done'
    end

    it 'does not offend eslint' do
      expect(`yarn run eslint`).to include 'Done'
    end
  RUBY
end
