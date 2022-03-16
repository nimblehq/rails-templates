# frozen_string_literal: true

insert_into_file 'Dangerfile', after: /eslint.lint.*\n/ do
  <<~RUBY

    # Runs slim-lint on modified and added files in the PR
    slim_lint.lint
  RUBY
end
