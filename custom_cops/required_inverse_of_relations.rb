# frozen_string_literal: true

module CustomCops
  class RequiredInverseOfRelations < RuboCop::Cop::Base
    MSG = 'Use inverse_of option when defining associations to prevent avoidable SQL queries and keep models in sync.'

    # Optimization: don't call `on_send` unless the method name is in this list
    RESTRICT_ON_SEND = %i[has_many belongs_to].freeze
    ASSOCIATION_METHODS = RESTRICT_ON_SEND.to_set

    def_node_matcher :missing_inverse_of_no_arguments?, <<~PATTERN
      (send nil? ASSOCIATION_METHODS (sym _))
    PATTERN

    def_node_matcher :missing_inverse_of_with_arguments?, <<~PATTERN
      (send nil? ASSOCIATION_METHODS (sym _) (hash $...))
    PATTERN

    def on_send(node)
      return add_offense(node) if missing_inverse_of_no_arguments?(node)

      return unless (hash_pairs = missing_inverse_of_with_arguments?(node))

      add_offense(node) unless contain_inverse_of?(hash_pairs)
    end

    private

    def contain_inverse_of?(nodes)
      pattern = RuboCop::NodePattern.new('(pair (sym :inverse_of) _)')

      nodes.any? { pattern.match(_1) }
    end
  end
end
