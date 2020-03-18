module Template
  class Application
    APP_NAME_SUFFIX = / Web$/.freeze

    attr_reader :app_name

    def initialize(app_name = ENV['APP_NAME'])
      @app_name = app_name
    end

    # Transform the app name from slug to human-readable name e.g. my-nimble-web -> My Nimble
    def humanized_name
      @humanized_name = app_name
                        .split(/[-_]/)
                        .map(&:capitalize)
                        .join(' ')
                        .gsub(APP_NAME_SUFFIX, '')
    end

    # Transform the name to use for creating the app directory in the project e.g. my-nimble-web -> my_nimble
    def directory_name
      @directory_name ||= humanized_name.downcase.gsub(' ', '_')
    end

    # Transform the name to use for the app module name e.g. my-nimble-web -> MyNimble
    def namespace
      @namespace ||= humanized_name.delete(' ')
    end
  end
end
