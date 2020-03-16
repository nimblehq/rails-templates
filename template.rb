require 'shellwords'

# Variables
APP_NAME = app_name
# Transform the app name from slug to human-readable name e.g. nimble-web -> Nimble
APP_NAME_HUMANIZED = app_name.split(/[-_]/).map(&:capitalize).join(' ').gsub(/ Web$/, '')
DOCKER_IMAGE = "nimblehq/#{APP_NAME}".freeze
RUBY_VERSION = '2.6.5'.freeze
POSTGRES_VERSION = '12.1'.freeze
REDIS_VERSION = '5.0.7'.freeze
# Variants
API_VARIANT = options[:api] || ENV['API'] == 'true'
WEB_VARIANT = !API_VARIANT

def apply_template!(template_root)
  use_source_path template_root

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
    use_source_path template_root

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
  @source_paths
end

# Prepend the required paths to the source paths to make the template files in those paths available
def use_source_path(source_path)
  @source_paths.unshift(source_path)
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

# Init the source path
@source_paths ||= []
# Setup the template root path
# If the template file is the url, clone the repo to the tmp directory
template_root = __FILE__ =~ %r{\Ahttps?://} ? remote_repository : __dir__
use_source_path template_root

if ENV['ADDON']
  addon_template_path = ".template/addons/#{ENV['ADDON']}/template.rb"

  abort 'This addon is not supported' unless File.exist?(addon_template_path)

  apply addon_template_path
else
  apply_template!(template_root)
end
