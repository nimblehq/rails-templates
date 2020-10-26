# frozen_string_literal: true

# Runs rails_best_practices on modified and added files in the PR
rails_best_practices.lint

# Runs Rubocop and submit comments on modified and added files
rubocop.lint(inline_comment: true, force_exclusion: true)

# Runs Brakeman on modified and added files
brakeman.run

# Runs Reek on modified and added files
reek.lint

# Suggests code changes in the PR
suggester.suggest

# Report your Ruby app test suite code coverage in Danger.
simplecov.report 'coverage/coverage.json'

# Report missing test coverage of new changes in Danger
undercover.report
