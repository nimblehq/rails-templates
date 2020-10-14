insert_into_file 'Gemfile', after: /# Authentications & Authorizations.*\n/ do
  <<~GEM
    gem 'devise' # Authentication solution for Rails with Warden
  GEM
end

insert_into_file 'Gemfile', after: /# Translations.*\n/ do
  <<~GEM
    # gem 'devise-i18n' # Translations for Devise
  GEM
end
