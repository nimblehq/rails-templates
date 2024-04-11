# frozen_string_literal: true

require_relative 'class_template/expression_category'

module CustomCops
  class ClassTemplate < RuboCop::Cop::Base
    include CustomCops::ExpressionCategory

    EXPRESSION_TYPE_ORDER = {
      extend: 0,
      include: 1,
      constant_assignment: 2,
      attribute_macro: 3,
      other_macro: 4,
      self_class_block: 5,
      public_class_method: 5,
      initialization: 6,
      public_instance_method: 7,
      alias: 8,
      alias_method: 8,
      protected_instance_method: 9,
      private_instance_method: 10
    }.freeze

    # Scan class body
    def on_class(node)
      expressions = top_level_expressions(node)

      state = { function_visibility: :public, expression_types: [] }
      expressions.each_with_object(state) { |expression, acc| process_expression(expression, acc) }

      validate_expressions_order(state[:expression_types])
    end

    private

    def top_level_expressions(class_node)
      return [] unless class_node.body

      # Multi-expression body
      return class_node.body.children if class_node.body.type == :begin

      # Single-expression body
      [class_node.body]
    end

    def process_expression(expression, acc)
      category = categorize(expression)

      if %i[protected private].include?(category)
        acc[:function_visibility] = category
      else
        category = "#{acc[:function_visibility]}_#{category}".to_sym if category == :instance_method
        acc[:expression_types] << { category: category, expression: expression }
      end
    end

    def validate_expressions_order(expressions)
      expressions = expressions.filter { _1[:category] != :unknown }

      expressions.each_cons(2) do |first, second|
        next unless EXPRESSION_TYPE_ORDER[first[:category]] > EXPRESSION_TYPE_ORDER[second[:category]]

        add_offense(
          second[:expression],
          message: error_message(second[:category], expressions)
        )
      end
    end

    # Find the correct spot for the out of order expression
    # rubocop:disable Metrics/MethodLength
    def error_message(out_of_order_expression, expressions)
      expressions.filter { _1[:category] != out_of_order_expression }
                 .each_with_index do |expression, index|
        error = if index.zero?
                  before_first_expression(expression, out_of_order_expression)
                elsif index == expressions.size - 1
                  after_last_expression(expression, out_of_order_expression)
                else
                  previous_expression = expressions[index - 1]
                  in_between_expressions(previous_expression, expression, out_of_order_expression)
                end

        return error if error
      end
    end
    # rubocop:enable Metrics/MethodLength

    def before_first_expression(current_expression, out_of_order_expression)
      unless EXPRESSION_TYPE_ORDER[out_of_order_expression] < EXPRESSION_TYPE_ORDER[current_expression[:category]]
        return
      end

      "#{out_of_order_expression} should come before `#{current_expression[:expression].source}`."
    end

    def after_last_expression(current_expression, out_of_order_expression)
      unless EXPRESSION_TYPE_ORDER[out_of_order_expression] > EXPRESSION_TYPE_ORDER[current_expression[:category]]
        return
      end

      "#{out_of_order_expression} should come after `#{current_expression[:expression].source}`."
    end

    def in_between_expressions(previous_expression, current_expression, out_of_order_expression)
      unless EXPRESSION_TYPE_ORDER[out_of_order_expression] < EXPRESSION_TYPE_ORDER[current_expression[:category]] &&
             EXPRESSION_TYPE_ORDER[out_of_order_expression] > EXPRESSION_TYPE_ORDER[previous_expression[:category]]
        return
      end

      "#{out_of_order_expression} should come after " \
        "`#{previous_expression[:expression].source}` " \
        "and before `#{current_expression[:expression].source}`."
    end
  end
end
