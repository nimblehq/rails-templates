
# frozen_string_literal: true

if Dir.exist?('.github/wiki')
  # Your existing code here
  use_source_path __dir__

  copy_file 'Add-new-svg-icon.md', '.github/wiki/Add-new-svg-icon.md'

  # SVG Sprite
  insert_into_file '.github/wiki/_Sidebar.md', after: /## Operations.*\n/ do
    <<~RUBY

      - [[Add new svg icon]]
    RUBY
  end
end

