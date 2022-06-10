############################
# Group: :development, :test
############################
insert_into_file 'Gemfile', after: /gem 'fabrication'.*\n/ do
  <<~RUBY.indent(2)
    # Testing
    gem 'rspec-rails', '~> 5.0.2' # Rails testing engine
  RUBY
end

insert_into_file 'Gemfile', after: /gem 'rubocop-rails'.*\n/ do
  <<~RUBY.indent(2)
    gem 'rubocop-rspec', require: false # Code style checking for RSpec files
  RUBY
end

############################
# Group: :test
############################
insert_into_file 'Gemfile', after: /gem 'json_matchers'.*\n/ do
  <<~RUBY.indent(2)
    gem 'rspec-retry' # Retry randomly failing rspec example.
  RUBY
end

############################
# Group: :development
############################
insert_into_file 'Gemfile', after: /gem 'spring'.*\n/ do
  <<~RUBY.indent(2)
    gem 'spring-commands-rspec' # This gem implements the rspec command for Spring.
  RUBY
end
