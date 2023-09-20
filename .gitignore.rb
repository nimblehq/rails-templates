# frozen_string_literal: true

append_to_file '.gitignore' do
  <<~IGNORE

    # Ignore folder information and IDE-specific files
    .DS_Store
    .idea/*
    .vscode

    # Ignore the test coverage results from SimpleCov
    /coverage
  IGNORE
end
