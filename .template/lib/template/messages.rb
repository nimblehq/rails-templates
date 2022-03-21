# frozen_string_literal: true

# rubocop:todo Style/ClassAndModuleChildren
class Template::Messages
  delegate :empty?, to: :messages

  def initialize
    @messages = []
  end

  def add(message)
    messages << message.chomp
  end

  def to_s
    messages.join("\n\n#{'-' * 80}\n\n")
  end

  private

  attr_reader :messages
end
# rubocop:enable Style/ClassAndModuleChildren
