# frozen_string_literal: true

insert_into_file 'Dangerfile', after: /eslint.lint.*\n/ do
  <<~DANGER_PLUGIN

    # Runs slim-lint on modified and added files in the PR
    slim_lint.lint
  DANGER_PLUGIN
end
