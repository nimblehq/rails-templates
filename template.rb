require 'shellwords'

# Variables
APP_NAME = app_name
RUBY_VERSION = '2.6.5'
# Options
OPTION_API_ONLY = options[:api]

def apply_template!
  use_source_paths [current_directory]

  delete_test_folder

  template 'Gemfile.tt', force: true

  template 'Dockerfile.tt'
  template 'docker-compose.dev.yml.tt'
  template 'docker-compose.test.yml.tt'
  template 'docker-compose.yml.tt'
  template '.env.tt'
  copy_file '.dockerignore'

  copy_file '.flayignore'
  template '.pronto.yml.tt'
  copy_file '.rubocop.yml'
  copy_file 'config.reek'

  copy_file '.semaphore.yml'
  template '.ruby-gemset.tt'
  template '.ruby-version.tt'
  copy_file '.editorconfig'
  copy_file 'Procfile'
  copy_file 'Procfile.dev'
  template 'README.md.tt', force: true

  apply 'bin/template.rb'
  apply 'config/template.rb'
  apply '.gitignore.rb'

  after_bundle do
    use_source_paths [__dir__]

    # Stop the spring before using the generators as it might hang for a long time
    # Issue: https://github.com/rails/spring/issues/486
    run 'spring stop'

    generate 'devise:install'
    apply 'spec/template.rb'
  end

  # Variants
  apply 'variants/web/template.rb' unless OPTION_API_ONLY
end

def source_paths
  @source_paths ||= []
end

# Set Thor::Actions source path for looking up the files
def use_source_paths(source_paths)
  @source_paths = source_paths
end

def current_directory
  @current_directory ||= __FILE__ =~ %r{\Ahttps?://} ? remote_repository : __dir__
end

def remote_repository
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
end

def delete_test_folder
  FileUtils.rm_rf('test')
end

apply_template!
