insert_into_file 'Dangerfile', after: %r{eslint.lint.*\n} do
  <<~EOT

  # Runs slim-lint on modified and added files in the PR
  slim_lint.lint
  EOT
end
