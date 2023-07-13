# frozen_string_literal: true

# SVG Sprite
insert_into_file 'Gemfile', after: /gem 'bcrypt'.*\n/ do
  <<~RUBY

    gem 'svg_sprite' # Create SVG sprites using SVG links.
  RUBY
end
