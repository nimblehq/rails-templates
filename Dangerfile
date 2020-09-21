# Make it more obvious that a PR is a work in progress and shouldn't be merged yet.
has_wip_label = github.pr_labels.any? { |label| label.include? "WIP" }
has_wip_title = github.pr_title.include? "[WIP]" || github.pr_title.include? "WIP"

if has_wip_label || has_wip_title
  message("Skipping Danger since PR is classed as Work in Progress")
  return
end

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
