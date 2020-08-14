# Runs Rubocop and submit comments only for changed lines
rubocop.lint(inline_comment: true, force_exclusion: true)

# Runs rails_best_practices on modified and added files in the PR
rails_best_practices.lint

# Runs Reek on modified and added files in the PR
reek.lint

# Runs Brakeman on modified and added files in the PR
brakeman.run(config_file: 'config/brakeman.yml')

# Suggests code changes in the PR
suggester.suggest

# Ensures nice and tidy commit messages
commit_lint.check

# Additional custom checks

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn('PR is classed as Work in Progress') if github.pr_title.include? 'WIP'
