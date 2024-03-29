# frozen_string_literal: true

# SVG Sprite
insert_into_file 'Gemfile', after: /gem 'danger'.*\n/ do
  <<~RUBY
    gem 'svgeez' # Gem for generating an SVG sprite from a folder of SVG icons.
  RUBY
end

# SVG Sprite
insert_into_file 'Gemfile', after: /gem 'bcrypt'.*\n/ do
  <<~RUBY
    gem 'inline_svg' # Use Inline SVG for styling SVG with CSS
  RUBY
end
