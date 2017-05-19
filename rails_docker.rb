require 'shellwords'
require_relative 'lib/rspec'
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
remove_file 'Gemfile'
copy_file 'rails_docker/Gemfile.txt', 'Gemfile'

# Docker
remove_file 'Dockerfile'
copy_file 'rails_docker/Dockerfile', 'Dockerfile'
gsub_file 'Dockerfile', '#{app_name}', "#{app_name}"

remove_file 'docker-compose.yml'
copy_file 'rails_docker/docker-compose.yml', 'docker-compose.yml'
gsub_file 'docker-compose.yml', '#{app_name}', "#{app_name}"

remove_file '.dockerignore'
copy_file 'rails_docker/.dockerignore', '.dockerignore'

copy_file 'rails_docker/application.yml', 'config/application.yml'
gsub_file 'config/application.yml', '#{app_name}', "#{app_name}"

copy_file 'rails_docker/test.sh', 'bin/test.sh' # shell script for run tests on docker

# Database.yml
remove_file 'config/database.yml'
copy_file 'rails_docker/database.yml', 'config/database.yml'
gsub_file 'config/database.yml', '#{app_name}', "#{app_name}"

# Removing turbolinks
remove_file 'app/assets/javascripts/application.js'
copy_file 'shared/app/assets/javascripts/application.js', 'app/assets/javascripts/application.js'

after_bundle do
  run "spring stop"

  # Devise configuration
  generate "devise:install"
  insert_into_file "config/environments/development.rb", after: "config.assets.raise_runtime_errors = true\n\n" do
    "  config.action_mailer.default_url_options = { host: \"localhost\", port: 3000 }"
  end

  #rspec
  setup_rspec

  #Modified Guardfile
  remove_file "Guardfile"
  copy_file 'shared/Guardfile', 'Guardfile'

  #create .rubocop.yml
  copy_file 'shared/.rubocop.yml', '.rubocop.yml'

  #shell script for run database on docker
  copy_file 'rails_docker/envsetup.sh', 'envsetup.sh'

  #guard
  run "bundle exec spring binstub --all"
  run "bundle exec spring binstub rspec"

  FileUtils.chmod 0755, 'envsetup.sh'
end
