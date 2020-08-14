insert_into_file 'Dangerfile', after: %r{commit_lint.check.*\n} do
  <<~EOT

    # Runs slim-lint on modified and added files in the PR
    slim_lint.lint

    # Runs eslint on modified and added files in the PR
    eslint.lint
  EOT
end
