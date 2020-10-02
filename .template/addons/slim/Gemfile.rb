insert_into_file 'Gemfile', after: %r{gem 'sass-rails'.*\n} do
  <<-EOT

  # Templating
  gem 'slim' # light weight template engine
  EOT
end

############################
# Group: :development, :test
############################

insert_into_file 'Gemfile', after: %r{gem 'danger'.*\n} do
  <<-EOT
  gem 'danger-slim_lint' # Lint slim files.
  EOT
end
