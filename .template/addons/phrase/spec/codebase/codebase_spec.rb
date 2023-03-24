# frozen_string_literal: true

insert_into_file 'spec/codebase/codebase_spec.rb', before: /end\Z/ do
  <<~RUBY.indent(2)

    # rubocop:disable RSpec/ExampleLength
    it 'does not offend Phrase Pull configuration' do
      locale_tags = Dir[File.expand_path(Rails.root.join('config', 'locales', '*.yml'))]
                    # ['campaign.en.yml', 'article.en.yml', 'campaign.th.yml', 'en.yml']
                    .map { |path| path.split('/').last }
                    # ['campaign', 'article', 'campaign', 'en']
                    .map { |path| path.split('.').first }
                    # ['campaign', 'article', 'en']
                    .uniq
                    # ['article', 'campaign', 'en']
                    .sort
      # replace en with root as `en` is not a tag
      locale_tags[locale_tags.index('en')] = 'root'

      phrase_pull_tags = YAML.load_file(Rails.root.join('.phrase.yml'))
                             .dig('phrase', 'pull', 'targets')
                             .map { |target| target.dig('params', 'tags') }
                             .sort

      expect(phrase_pull_tags).to eq locale_tags
    end
    # rubocop:enable RSpec/ExampleLength
  RUBY
end
