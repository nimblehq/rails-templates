insert_into_file 'config/environment.rb', after: %r{require_relative 'application'\n} do
  <<~EOT
  
    # Require all modules in the lib
    Dir[Rails.root.join('lib', '#{@template_application.directory_name}', '**', '*.rb')].sort.each { |f| require f }
  EOT
end
