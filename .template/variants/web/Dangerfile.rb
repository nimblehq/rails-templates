insert_into_file 'Dangerfile', after: %r{suggester.suggest.*\n} do
  <<~RUBY

    # Runs ESLint on modified and added files in the PR
    eslint.lint
  RUBY
end
