insert_into_file 'Dangerfile', after: %r{suggester.suggest.*\n} do
  <<~EOT

    # Runs slim-lint on modified and added files in the PR
    slim_lint.lint

    # Runs eslint on modified and added files in the PR
    eslint.lint
  EOT
end
