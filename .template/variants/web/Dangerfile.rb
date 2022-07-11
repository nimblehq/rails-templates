# frozen_string_literal: true

insert_into_file 'Dangerfile', after: /suggester.suggest.*\n/ do
  <<~RUBY

    # Runs ESLint on modified and added files in the PR
    eslint.lint

    # Runs Stylelint on all files
    stylelint.lint
  RUBY
end
