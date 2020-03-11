require 'shellwords'

# Variables
APP_NAME = app_name
# Transform the app name from slug to human-readable name e.g. nimble-web -> Nimble
APP_NAME_HUMANIZED = app_name.split(/[-_]/).map(&:capitalize).join(' ').gsub(/ Web$/, '')
DOCKER_IMAGE = "nimblehq/#{APP_NAME}"
RUBY_VERSION = '2.6.5'
POSTGRES_VERSION = '12.1'
REDIS_VERSION = '5.0.7'
# Variants
API_VARIANT = options[:api]
WEB_VARIANT = !options[:api]

def apply_template!
  use_source_paths [current_directory]

  delete_test_folder

  directory '.github'

  template 'Gemfile.tt', force: true

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
    use_source_paths [current_directory]

    # Stop the spring before using the generators as it might hang for a long time
    # Issue: https://github.com/rails/spring/issues/486
    run 'spring stop'

    generate 'devise:install'
    apply 'spec/template.rb'
  end

  # Add-ons - [Default]
  apply '.template/addons/docker/template.rb'
  apply '.template/addons/semaphore/template.rb'

  # Variants
  apply '.template/variants/api/template.rb' if API_VARIANT
  apply '.template/variants/web/template.rb' if WEB_VARIANT
end

# Set Thor::Actions source path for looking up the files
def source_paths
  @source_paths ||= []
end

# Prepend the required paths to the source paths to make the template files in those paths available
def use_source_paths(source_paths)
  @source_paths.unshift(*source_paths)
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
    'https://github.com/nimblehq/rails-templates.git',
    tempdir
  ].map(&:shellescape).join(' ')

  if (branch = __FILE__[%r{rails-templates/(.+)/template.rb}, 1])
    Dir.chdir(tempdir) { git checkout: branch }
  end

  tempdir
end

def delete_test_folder
  FileUtils.rm_rf('test')
end

apply_template!
