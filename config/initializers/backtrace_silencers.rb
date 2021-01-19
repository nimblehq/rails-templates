gsub_file 'config/initializers/backtrace_silencers.rb',
  "Rails.backtrace_cleaner.remove_silencers! if ENV[\"BACKTRACE\"]",
  <<-EOT
Rails.backtrace_cleaner.remove_silencers!

# Add backtrace silencer
# Default silencer is removing backtrace involving engines files
# Our silencer also checks for engines directory
# Ref: https://github.com/rails/rails/blob/master/railties/lib/rails/backtrace_cleaner.rb
Rails.backtrace_cleaner.add_silencer do |line|
  !(Rails::BacktraceCleaner::APP_DIRS_PATTERN.match?(line) || /^engines/.match?(line))
end

  EOT
