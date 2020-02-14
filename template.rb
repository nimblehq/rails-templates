require 'shellwords'

# Variables
APP_NAME = app_name
RUBY_VERSION = '2.6.5'

def apply_template!
  delete_test_folder

  template 'Gemfile.tt', force: true

  template 'Dockerfile.tt'
  template 'docker-compose.dev.yml.tt'
  template 'docker-compose.test.yml.tt'
  template 'docker-compose.yml.tt'
  template '.env.tt'
  copy_file '.dockerignore'

  copy_file '.eslintignore'
  copy_file '.eslintrc'
  copy_file '.flayignore'
  template '.pronto.yml.tt'
  copy_file '.pronto_eslint_npm.yml'
  copy_file '.rubocop.yml'
  copy_file '.scss-lint.yml'
  copy_file 'config.reek'

  copy_file '.semaphore.yml'
  template '.ruby-gemset.tt'
  template '.ruby-version.tt'
  copy_file '.editorconfig'
  copy_file '.npmrc'
  copy_file 'Procfile'
  copy_file 'Procfile.dev'
  copy_file 'Guardfile'
  template 'README.md.tt', force: true

  apply 'app/template.rb'
  apply 'bin/template.rb'
  apply 'config/template.rb'

  apply 'package.json.rb'
  apply '.gitignore.rb'

  remove_turbolinks

  after_bundle do
    run 'spring stop'

    generate 'devise:install'

    apply 'config/webpack/template.rb'

    apply 'spec/template.rb'
  end
end

# Add the current directory to the path Thor uses to look up files
def current_directory
  @current_directory ||=
    if __FILE__ =~ %r{\Ahttps?://}
      require 'tmpdir'
      tempdir = Dir.mktmpdir('rails-templates')
      at_exit { FileUtils.remove_entry(tempdir) }
      git clone: [
              '--quiet',
              '--depth=1',
              'https://github.com/nimblehq/rails-templates.git',
              tempdir
          ].map(&:shellescape).join(' ')
      tempdir
    else
      File.expand_path(File.dirname(__FILE__))
    end
end

def source_paths
  [current_directory] + Array(super)
end

def delete_test_folder
  FileUtils.rm_rf('test')
end

def remove_turbolinks
  gsub_file('app/views/layouts/application.html.erb', %r{, 'data-turbolinks-track': 'reload'}, '')
  gsub_file('app/javascript/packs/application.js', %r{^require\(\"turbolinks\"\).start\(\)\n}, '')
  gsub_file('package.json', %r{"turbolinks": .+\n}, '')
end

apply_template!
