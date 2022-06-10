# Hotwire Rails
insert_into_file 'Gemfile', after: /gem 'bcrypt'.*\n/ do
  <<~RUBY.indent(2)

    gem 'turbo-rails' # Hotwire's SPA-like page accelerator
    gem 'stimulus-rails' # Hotwire's modest JavaScript framework
  RUBY
end
