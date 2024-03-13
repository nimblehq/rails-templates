# frozen_string_literal: true

insert_into_file 'Gemfile', after: /gem 'pundit'.*\n/ do
  <<~RUBY

    # Templating
    gem 'slim-rails' # Slim generator for Rails
  RUBY
end

############################
# Group: :development, :test
############################

insert_into_file 'Gemfile', after: /gem 'danger'.*\n/ do
  <<~RUBY.indent(2)
    gem 'danger-slim_lint' # Lint slim files.
  RUBY
end
