insert_into_file 'config/environments/production.rb', before: /%r{end\nend\Z}/ do
  <<~CODE
    if ENV["RAILS_LOG_TO_STDOUT"].present?
      logger           = ActiveSupport::Logger.new(STDOUT)
      logger.formatter = config.log_formatter
      config.logger = ActiveSupport::TaggedLogging.new(logger)
    end
  CODE
end
