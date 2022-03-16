append_to_file '.gitignore' do
  <<~IGNORE

    # Ignore folder information and IDE-specific files
    .DS_Store
    .idea/*

    # Ignore the test coverage results from SimpleCov
    /coverage
  IGNORE
end
