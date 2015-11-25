require 'shellwords'
# Add the current directory to the path Thor uses
# to look up files

def current_directory
  @current_directory ||=
      if __FILE__ =~ %r{\Ahttps?://}
        tempdir = Dir.mktmpdir("rails-templates")
        at_exit { FileUtils.remove_entry(tempdir) }
        git clone: [
                "--quiet",
                "https://github.com/nimbl3/rails-templates.git",
                tempdir
            ].map(&:shellescape).join(" ")

        tempdir
      else
        File.expand_path(File.dirname(__FILE__))
      end
end

def source_paths
  Array(super) + [current_directory]
end

# Gemfile
remove_file "Gemfile"
copy_file 'Gemfile.txt', 'Gemfile'

# Docker
remove_file 'docker-compose.yml'
copy_file 'docker-compose.yml', 'docker-compose.yml'
gsub_file 'docker-compose.yml', '#{app_name}', "#{app_name}"

remove_file '.dockerignore'
copy_file '.dockerignore', '.dockerignore'


# Database.yml
inside 'config' do
  remove_file 'database.yml'
  create_file 'database.yml' do
    <<-EOF
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5

development:
  <<: *default
  host:     <%= ENV['DB_HOST'] %>
  port:     <%= ENV['DB_PORT'] %>
  username: postgres
  database: #{app_name}_development

test:
  <<: *default
  host:     <%= ENV['DB_HOST'] %>
  port:     <%= ENV['DB_PORT'] %>
  username: postgres
  database: #{app_name}_test

production:
  url: <%= ENV['DATABASE_URL'] %>
    EOF
  end
end

after_bundle do
  run "spring stop"

  # Devise configuration
  generate "devise:install"
  insert_into_file "config/environments/development.rb", after: "config.assets.raise_runtime_errors = true\n\n" do
    "  config.action_mailer.default_url_options = { host: \"localhost\", port: 3000 }"
  end

  #rspec
  generate "rspec:install"
  remove_file ".rspec"
  copy_file '.rspec', '.rspec'

  #modified spec_helper
  remove_file "spec/spec_helper.rb"
  copy_file 'rspec/spec_helper.rb', 'spec/spec_helper.rb'

  #modified rails_helper
  remove_file "spec/rails_helper.rb"
  copy_file 'rspec/rails_helper.rb', 'spec/rails_helper.rb'

  # folder for fabricators
  run 'mkdir spec/fabricators'
  run 'mkdir spec/support'

  # Capybara
  copy_file 'rspec/support/capybara.rb', 'spec/support/capybara.rb'
  # Shoulda matchers
  copy_file 'rspec/support/shoulda_matchers.rb', 'spec/support/shoulda_matchers.rb'

  #guard
  run "guard init rspec"
  run "guard init rubocop"
  run "zeus-parallel_tests init"

  #Modified Guardfile
  remove_file "Guardfile"
  copy_file 'Guardfile', 'Guardfile'

  #Modified custom_plan.rb
  remove_file "custom_plan.rb"
  copy_file 'custom_plan.rb', 'custom_plan.rb'

  #create .rubocop.yml
  copy_file '.rubocop.yml', '.rubocop.yml'

  #shell script for run database on docker
  copy_file 'envsetup.sh', 'envsetup.sh'
  FileUtils.chmod 0755, 'envsetup.sh'
end


