# frozen_string_literal: true

require 'rubocop'
require_relative '../../custom_cops/class_template/expression_category'

describe CustomCops::ExpressionCategory, :config do
  context 'given an include expression' do
    it 'returns :include' do
      expect(expression_category('include Foo')).to be(:include)
      expect(expression_category('self.include Foo')).to be(:include)
    end
  end

  context 'given an extend expression' do
    it 'returns :extend' do
      expect(expression_category('extend Foo')).to be(:extend)
      expect(expression_category('self.extend Foo')).to be(:extend)
    end
  end

  context 'given a constant assignment' do
    it 'returns :constant_assignment' do
      expect(expression_category("HELLO = 'world'.freeze")).to be(:constant_assignment)
      expect(expression_category('HELLO = WORLD')).to be(:constant_assignment)
    end
  end

  context 'given an attribute macro' do
    context 'given the attribute macro only has a single field' do
      it 'returns :attribute_macro' do
        expect(expression_category('attr_reader :hello')).to be(:attribute_macro)
        expect(expression_category('self.attr_reader :hello')).to be(:attribute_macro)

        expect(expression_category('attr_writer :hello')).to be(:attribute_macro)
        expect(expression_category('self.attr_writer :hello')).to be(:attribute_macro)

        expect(expression_category('attr_accessor :hello')).to be(:attribute_macro)
        expect(expression_category('self.attr_accessor :hello')).to be(:attribute_macro)
      end
    end

    context 'given the attribute macro has multiple fields' do
      it 'returns :attribute_macro' do
        expect(expression_category('attr_reader :hello, :world')).to be(:attribute_macro)
        expect(expression_category('self.attr_reader :hello, :world')).to be(:attribute_macro)

        expect(expression_category('attr_writer :hello, :world')).to be(:attribute_macro)
        expect(expression_category('self.attr_writer :hello, :world')).to be(:attribute_macro)

        expect(expression_category('attr_accessor :hello, :world')).to be(:attribute_macro)
        expect(expression_category('self.attr_accessor :hello, :world')).to be(:attribute_macro)
      end
    end
  end

  context 'given a macro expression' do
    it 'returns :other_macro' do
      expect(expression_category('validates :name')).to be(:other_macro)
      expect(expression_category("scope :in_advance, -> { where('started_at > ?', Time.current) }")).to be(:other_macro)
    end
  end

  context 'given a self class block' do
    context 'given the block has no methods' do
      it 'returns :self_class_block' do
        code = <<~RUBY
          class << self
          end
        RUBY

        expect(expression_category(code)).to be(:self_class_block)
      end
    end

    context 'given the block has ONE method' do
      it 'returns :self_class_block' do
        code = <<~RUBY
          class << self
            def foo
              'foo'
            end
          end
        RUBY

        expect(expression_category(code)).to be(:self_class_block)
      end
    end

    context 'given the block has multiple methods' do
      it 'returns :self_class_block' do
        code = <<~RUBY
          class << self
            def foo
              'foo'
            end

            def bar
              'bar'
            end
          end
        RUBY

        expect(expression_category(code)).to be(:self_class_block)
      end
    end
  end

  context 'given a public class method definition' do
    context 'given the method has no arguments' do
      it 'returns :public_class_method' do
        code = <<~RUBY
          def self.foo
            "bar"
          end
        RUBY

        expect(expression_category(code)).to be(:public_class_method)
      end
    end

    context 'given the method has arguments' do
      it 'returns :public_class_method' do
        code = <<~RUBY
          def self.foo(a, _b, c)
            "bar"
          end
        RUBY

        expect(expression_category(code)).to be(:public_class_method)
      end
    end
  end

  context 'given an initialize method definition' do
    it 'returns :initialization' do
      code = <<~RUBY
        def initialize(a, _b, c)
          @sum = a + c
        end
      RUBY

      expect(expression_category(code)).to be(:initialization)
    end
  end

  context 'given an instance method definition' do
    context 'given the method has no arguments' do
      it 'returns :instance_method' do
        code = <<~RUBY
          def foo
            "bar"
          end
        RUBY

        expect(expression_category(code)).to be(:instance_method)
      end
    end

    context 'given the method has arguments' do
      it 'returns :instance_method' do
        code = <<~RUBY
          def foo(a, _b, c)
            "bar"
          end
        RUBY

        expect(expression_category(code)).to be(:instance_method)
      end
    end
  end

  context 'given an alias expression' do
    it 'returns :alias' do
      code = <<~RUBY
        alias foo bar
      RUBY

      expect(expression_category(code)).to be(:alias)
    end
  end

  context 'given an alias_method expression' do
    context 'given arguments are atoms' do
      it 'returns :alias_method' do
        code = <<~RUBY
          alias_method :foo, :bar
        RUBY

        expect(expression_category(code)).to be(:alias_method)
      end
    end

    context 'given arguments are strings' do
      it 'returns :alias_method' do
        code = <<~RUBY
          alias_method 'foo', "bar_#{1 + 1}"
        RUBY

        expect(expression_category(code)).to be(:alias_method)
      end
    end
  end

  context 'given an protected statement' do
    it 'returns :protected' do
      code = <<~RUBY
        protected
      RUBY

      expect(expression_category(code)).to be(:protected)
    end
  end

  context 'given an private statement' do
    it 'returns :private' do
      code = <<~RUBY
        private
      RUBY

      expect(expression_category(code)).to be(:private)
    end
  end

  def expression_category(code)
    dummy_class = Class.new { include CustomCops::ExpressionCategory }
    source = RuboCop::ProcessedSource.new(code, RUBY_VERSION.to_f)

    dummy_class.new.categorize(source.ast)
  end
end
