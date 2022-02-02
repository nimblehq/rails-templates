use_source_path __dir__

directory '.github'

# Split README.md file to multiple wiki pages
original_readme = File.read 'README.md'

create_file '.github/wiki/Getting-Started.md' do
  get_content_between(original_readme, "## Getting Started", "## Testing")
end

create_file '.github/wiki/Testing.md' do
  get_content_between(original_readme, "## Testing", "## CI/CD")
end

FileUtils.mv '.github/workflows/README.md', '.github/wiki/CI-CD.md'

gsub_file 'README.md', /## Getting Started.*/m do
  <<~README
    ## Documentation

    Please check out full documentation on the [wiki](link to github wiki goes here).
  README
end

@template_instructions.add(
  <<~INSTRUCTION
    * Github wiki

    1. On the repository, create an empty wiki page to init the wiki directory
    2. Pick an account to commit the wiki (your own account or a bot account)
    3. On the selected account, generate the Github token with `repo` scope
    4. Set up secrets
      - `GH_EMAIL`: an email of the account
      - `GH_TOKEN`: the generated Github token from step 3
  INSTRUCTION
)
