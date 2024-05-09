# frozen_string_literal: true

require 'rubocop'

module CustomCops
  module ExpressionCategory
    extend RuboCop::NodePattern::Macros

    ATTRIBUTE_MACROS = %i[attr_reader attr_writer attr_accessor].to_set

    CATEGORIES = %i[
      extend include constant_assignment attribute_macro alias_method protected private
      other_macro self_class_block public_class_method initialization instance_method alias
    ].freeze

    # extend SomeModule
    def_node_matcher :extend?, <<~PATTERN
      (send {nil? | self} :extend const)
    PATTERN

    # include SomeModule
    def_node_matcher :include?, <<~PATTERN
      (send {nil? | self} :include const)
    PATTERN

    # HELLO = 'world'.freeze
    def_node_matcher :constant_assignment?, <<~PATTERN
      (casgn nil? _ _)
    PATTERN

    # attr_reader :foo, :bar
    # attr_writer :baz
    def_node_matcher :attribute_macro?, <<~PATTERN
      (send {nil? | self} ATTRIBUTE_MACROS sym+)
    PATTERN

    # validates :foo, presence: true
    def_node_matcher :other_macro?, <<~PATTERN
      (send {nil? | self} _ _+)
    PATTERN

    # class << self
    #   def foo
    #     'bar'
    #   end
    # end
    def_node_matcher :self_class_block?, <<~PATTERN
      (sclass self _)
    PATTERN

    # def self.foo
    #   "bar"
    # end
    def_node_matcher :public_class_method?, <<~PATTERN
      (defs self _ args _)
    PATTERN

    # def initialize(a, b)
    # end
    def_node_matcher :initialization?, <<~PATTERN
      (def :initialize args _)
    PATTERN

    # def method(a, b)
    # end
    def_node_matcher :instance_method?, <<~PATTERN
      (def _ args _)
    PATTERN

    # alias foo bar
    # alias :foo :bar
    def_node_matcher :alias?, <<~PATTERN
      (alias sym sym)
    PATTERN

    # alias_method :foo, :bar
    # alias_method 'foo', 'bar'
    def_node_matcher :alias_method?, <<~PATTERN
      (send {nil? | self} :alias_method _ _)
    PATTERN

    # protected
    def_node_matcher :protected?, <<~PATTERN
      (send {nil? | self} :protected)
    PATTERN

    # private
    def_node_matcher :private?, <<~PATTERN
      (send {nil? | self} :private)
    PATTERN

    # Categorize the expression of the class body
    def categorize(expression)
      CATEGORIES.find { |category| send(:"#{category}?", expression) } || :unknown
    end
  end
end
