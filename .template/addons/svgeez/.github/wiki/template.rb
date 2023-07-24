# frozen_string_literal: true

if Dir.exist?('.github/wiki')
  use_source_path __dir__

  copy_file 'Managing-SVG-Icons.md', '.github/wiki/Managing-SVG-Icons.md'

  # SVG Sprite
  insert_into_file '.github/wiki/_Sidebar.md', after: /## Operations.*\n/ do
    <<~RUBY
      - [[Managing SVG icons]]
    RUBY
  end
end
