# frozen_string_literal: true

insert_into_file 'Gemfile', after: /gem 'pundit'.*\n/ do
  <<~GEM

    # Templating
    gem 'slim' # light weight template engine
  GEM
end

############################
# Group: :development, :test
############################

insert_into_file 'Gemfile', after: /gem 'danger'.*\n/ do
  <<~GEM.indent(2)
    gem 'danger-slim_lint' # Lint slim files.
  GEM
end
