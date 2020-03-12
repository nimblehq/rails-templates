module Template
  class Errors
    delegate :empty?, to: :errors

    def initialize
      @errors = []
    end

    def add(error_message)
      errors << error_message
    end

    def to_s
      errors.join("#{'-' * 80}\n")
    end

    private

    attr_reader :errors
  end
end
