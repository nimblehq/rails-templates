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
copy_file 'rails_docker/Gemfile.txt', 'Gemfile'

# Docker
remove_file 'docker-compose.yml'
copy_file 'rails_docker/docker-compose.yml', 'docker-compose.yml'
gsub_file 'docker-compose.yml', '#{app_name}', "#{app_name}"

remove_file '.dockerignore'
copy_file 'rails_docker/.dockerignore', '.dockerignore'


# Database.yml
remove_file 'config/database.yml'
copy_file 'rails_docker/database.yml', 'config/database.yml'
gsub_file 'config/database.yml', '#{app_name}', "#{app_name}"

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
  copy_file 'shared/rspec/.rspec', '.rspec'

  #modified spec_helper
  remove_file "spec/spec_helper.rb"
  copy_file 'shared/rspec/spec_helper.rb', 'spec/spec_helper.rb'

  #modified rails_helper
  remove_file "spec/rails_helper.rb"
  copy_file 'shared/rspec/rails_helper.rb', 'spec/rails_helper.rb'

  # folder for fabricators
  run 'mkdir spec/fabricators'
  run 'mkdir spec/support'

  # Capybara
  copy_file 'shared/rspec/support/capybara.rb', 'spec/support/capybara.rb'
  # Shoulda matchers
  copy_file 'shared/rspec/support/shoulda_matchers.rb', 'spec/support/shoulda_matchers.rb'

  #guard
  run "guard init rspec"
  run "guard init rubocop"
  run "zeus-parallel_tests init"

  #Modified Guardfile
  remove_file "Guardfile"
  copy_file 'shared/Guardfile', 'Guardfile'

  #Modified custom_plan.rb
  remove_file "custom_plan.rb"
  copy_file 'shared/custom_plan.rb', 'custom_plan.rb'

  #create .rubocop.yml
  copy_file 'shared/.rubocop.yml', '.rubocop.yml'

  #shell script for run database on docker
  copy_file 'rails_docker/envsetup.sh', 'envsetup.sh'
  FileUtils.chmod 0755, 'envsetup.sh'
end


