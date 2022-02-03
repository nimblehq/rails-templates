insert_into_file 'spec/codebase/codebase_spec.rb', before: %r{end\Z} do
  <<~RUBY.indent(2)

    # rubocop:disable RSpec/ExampleLength
    it 'does not offend PhraseApp Pull configuration' do
      locale_tags = Dir[File.expand_path(Rails.root.join('config', 'locales', '*.yml'))]
                    .map { |path| path.split('/').last } # ["campaign.en.yml", "article.en.yml", "campaign.th.yml"]
                    .map { |path| path.split('.').first } # ["campaign", "article", "campaign"]
                    .uniq # ["campaign", "article"]
                    .sort # ["article", "campaign"]
      phrase_app_pull_tags = YAML
                            .load_file(Rails.root.join('.phraseapp.yml'))
                            .dig('phraseapp', 'pull', 'targets')
                            .map { |target| target.dig('params', 'tags') }
                            .sort

      expect(phrase_app_pull_tags).to eq locale_tags
    end
    # rubocop:enable RSpec/ExampleLength
  RUBY
end
