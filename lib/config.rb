def setup_config
  remove_file 'config/database.yml'

  FileUtils.cp_r "#{current_directory}/shared/config/.", 'config/'

  # Replace app_name
  gsub_file 'config/application.yml', '#{app_name}', "#{app_name}"
  gsub_file 'config/database.yml', '#{app_name}', "#{app_name}"

  add_sidekiq_config
end

def add_sidekiq_config
  insert_into_file 'config/application.rb', after: %r{config.generators.system_tests.+\n} do
    <<-EOT
    
    # Set the queuing backend to `Sidekiq`
    # 
    # Be sure to have the adapter's gem in your Gemfile
    # and follow the adapter's specific installation
    # and deployment instructions.
    config.active_job.queue_adapter = :sidekiq

    # Prefix the queue name of all jobs with Rails ENV
    config.active_job.queue_name_prefix = Rails.env
    EOT
  end
end
