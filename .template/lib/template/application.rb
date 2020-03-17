module Template
  class Application
    attr_reader :app_name

    def initialize(app_name = ENV['APP_NAME'])
      @app_name = app_name
    end

    # Transform the app name from slug to human-readable name e.g. nimble-web -> Nimble
    def humanized_name
      @humanized_name = app_name
                          .split(/[-_]/)
                          .map(&:capitalize)
                          .join(' ')
                          .gsub(/ Web$/, '')
    end

    def directory_name
      @directory_name ||= humanized_name.downcase.gsub(' ', '_')
    end

    def namespace
      @namespace ||= humanized_name.delete(' ')
    end
  end
end
