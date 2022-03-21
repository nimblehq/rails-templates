# frozen_string_literal: true

insert_into_file 'Gemfile', after: /# Authentications & Authorizations.*\n/ do
  <<~RUBY
    gem 'devise' # Authentication solution for Rails with Warden
  RUBY
end

insert_into_file 'Gemfile', after: /# Translations.*\n/ do
  <<~RUBY
    # gem 'devise-i18n' # Translations for Devise
  RUBY
end
