# frozen_string_literal: true

# SVG Sprite
insert_into_file 'Gemfile', after: /gem 'danger'.*\n/ do
  <<~RUBY

    # Svgeez
    gem 'svgeez' # Gem for generating an SVG sprite from a folder of SVG icons.
    gem 'inline_svg' # Use Inline SVG for styling SVG with CSS
  RUBY
end
