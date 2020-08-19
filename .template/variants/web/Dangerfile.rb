insert_into_file 'Dangerfile', after: %r{suggester.suggest.*\n} do
  <<~EOT

    # Runs ESLint on modified and added files in the PR
    eslint.lint
  EOT
end
