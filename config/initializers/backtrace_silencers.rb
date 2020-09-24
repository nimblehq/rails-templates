gsub_file 'config/initializers/backtrace_silencers.rb', '# Rails.backtrace_cleaner.remove_silencers!', "Rails.backtrace_cleaner.remove_silencers!\n"

insert_into_file 'config/initializers/backtrace_silencers.rb', after: "Rails.backtrace_cleaner.remove_silencers!\n" do
  <<-EOT
  
# Add backtrace silencer
# Default silencer is removing backtrace involving engines files
# Our silencer also checks for engines directory
# Ref: https://github.com/rails/rails/blob/master/railties/lib/rails/backtrace_cleaner.rb
Rails.backtrace_cleaner.add_silencer do |line|
  !(Rails::BacktraceCleaner::APP_DIRS_PATTERN.match?(line) || /^engines/.match?(line))
end
  
  EOT
end
