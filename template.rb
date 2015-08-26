def source_paths
  Array(super) + 
    [File.expand_path(File.dirname(__FILE__))]
end

class UserSelection
  attr_reader :database, :message_bus_or_not

  def initialize(database, message_bus_or_not)
    @database = database
    @message_bus_or_not = message_bus_or_not
  end
end

# Return "pg" or "mysql"
def ask_for_db
  answer_number = ask "What database do you want?\n ---> (1) PostgreSQL\n ---> (2) MySQL\n ---> "
  case answer_number.to_i
  when 1
    "pg"
  when 2
    "mysql"
  else
    "pg"
  end
end

# Return "yes" or "no"
def ask_for_message_bus
  message_bus_or_not = ask "Do you want to use message_bus? (Yn)"
  if message_bus_or_not.downcase == "y"
    "yes"
  else
    "no"
  end
end

def generate_gem_file(db)
  if db == "mysql"
    db_gem = "mysql2"
  else
    db_gem = "pg"
  end

<<-EOF
source 'https://rubygems.org'

ruby '2.2.3'

# Backend
gem 'rails', '4.2.3'
gem '#{db_gem}'

# Authentication/Authorization
gem 'devise'
gem 'doorkeeper'

# Assets
gem 'jquery-rails'
gem 'autoprefixer-rails'

# File upload
gem 'paperclip'

# Caching
gem 'dalli'

# Cron/Background jobs
gem 'delayed_job_active_record'
gem 'clockwork'
gem 'daemons'

# Web server
gem 'puma'

# Deployment
gem 'mina'
gem 'mina_hipchat', github: 'nimbl3/mina_hipchat'
gem 'mina-clockwork', require: false
gem 'mina-puma', require: false

# Misc
gem 'gon'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'pry-rails'
  gem 'dotenv-rails'
end
EOF
end

def generate_database_file(db)
  if db == "mysql"
    db_adapter = "mysql2"
  else
    db_adapter = "postgresql"
  end

<<-EOF
default: &default
  adapter: #{db_adapter}
  pool: 5

development:
  <<: *default
  database: #{app_name}_development
  timeout: 5000  

test:
  <<: *default
  database: #{app_name}_test

staging:
  <<: *default
  host:     <%= ENV['APP_DATABASE_HOST'] %>
  database: <%= ENV['APP_DATABASE_NAME'] %>
  username: <%= ENV['APP_DATABASE_USER'] %>
  password: <%= ENV['APP_DATABASE_PASSWORD'] %>

production:
  <<: *default
  host:     <%= ENV['APP_DATABASE_HOST'] %>
  database: <%= ENV['APP_DATABASE_NAME'] %>
  username: <%= ENV['APP_DATABASE_USER'] %>
  password: <%= ENV['APP_DATABASE_PASSWORD'] %>
EOF
end

# DEV_SCRIPT = <<-EOF
# namespace :development do
#   desc "Run all application dependencies (Memcached, Delayed_job, ...) before starting rails server in dev mode"
#   task start: :environment do
#     puts "\\n-----> Setup Memcached"
#     system "brew services stop memcached"
#     system "brew services start memcached"

#     puts "\\n-----> Setup Delayed Job"
#     system "bin/delayed_job stop"
#     system "bin/delayed_job start"

#     puts "\\n----- ALL SET UP -----\\n"
#   end
# end
# EOF

# Start asking for app options ...
database = ask_for_db
message_bus_or_not = ask_for_message_bus

user_selection = UserSelection.new(database, message_bus_or_not)

remove_file "Gemfile"
create_file "Gemfile" do
  generate_gem_file(user_selection.database)
end

if user_selection.message_bus_or_not == "yes"
  # Insert message_bus gem into Gemfile
  insert_into_file "Gemfile", before: "group :development, :test do" do
    "# Message bus (real-time)\ngem 'message_bus'\n\n"
  end
  
  # Copy message-bus.js from git repo (master branch)
  run "curl -o vendor/assets/javascripts/message-bus.js https://raw.githubusercontent.com/SamSaffron/message_bus/master/assets/message-bus.js"

  # Insert '//= require message-bus' into application.js
  insert_into_file "app/assets/javascripts/application.js", before: "//= require_tree ." do
    "//= require message-bus\n"
  end

  # Configure redis url for message bus
  create_file "config/initializers/message_bus.rb" do
    "MessageBus.redis_config = { url: ENV['REDIS_URL'] }"
  end
end

inside "config" do
  # Create staging.rb file
  inside "environments" do
    run "cp production.rb staging.rb"
  end

  remove_file "database.yml"
  create_file "database.yml" do
    generate_database_file(user_selection.database)
  end
end

after_bundle do
  # Devise configuration
  run "rails g devise:install"
  insert_into_file "config/environments/development.rb", after: "config.assets.raise_runtime_errors = true\n\n" do
    "  config.action_mailer.default_url_options = { host: \"localhost\", port: 3000 }"
  end

  # Delayed_job configuration
  run "rails generate delayed_job:active_record"
  environment do 
    "config.active_job.queue_adapter = :delayed_job"
  end

  # Create a rake task for running all app dependecies (Memcached, Delayed_job, ...) 
  # before starting rails server in dev mode
  # inside "lib/tasks" do
  #   create_file "development.rake" do
  #     DEV_SCRIPT
  #   end
  # end
end