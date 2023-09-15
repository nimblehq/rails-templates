# frozen_string_literal: true

# Runs Rubocop and submit comments on modified and added files
rubocop.lint(inline_comment: true, force_exclusion: true)

# Runs Brakeman on modified and added files
brakeman.run('./')

# Runs Reek on modified and added files
reek.lint

# Suggests code changes in the PR
suggester.suggest

# Report your Ruby app test suite code coverage in Danger.
# Copied from the report method to fix the wrong method called on line:31
# https://github.com/marcelofabri/danger-simplecov_json/blob/master/lib/simplecov_json/plugin.rb#L31
# rubocop:disable Style/GuardClause, Style/SignalException
coverage_path = 'coverage/coverage.json'
if File.exist? coverage_path
  coverage_json = JSON.parse(File.read(coverage_path), symbolize_names: true)
  metrics = coverage_json[:metrics]
  percentage = metrics[:covered_percent]
  lines = metrics[:covered_lines]
  total_lines = metrics[:total_lines]

  formatted_percentage = format('%.02f', percentage)
  # Use markdown instead of message
  markdown("Code coverage is now at **#{formatted_percentage}% (#{lines}/#{total_lines} lines)**")
else
  fail('Code coverage data not found')
end
# rubocop:enable Style/GuardClause, Style/SignalException

# Report missing test coverage of new changes in Danger
undercover.report
