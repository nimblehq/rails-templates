# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../custom_cops/class_template'

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense
end

describe CustomCops::ClassTemplate, :config do
  context 'given an out of order expression' do
    it 'registers an offense' do
      expect_offense(<<~RUBY)
        class Test
          include B
          extend A
          ^^^^^^^^ extend should come before `include B`.
        end
      RUBY

      expect_offense(<<~RUBY)
        class Test
          extend A
          include B

          def initialize
            {foo: "bar"}
          end

          CONSTANT = 1
          ^^^^^^^^^^^^ constant_assignment should come after `include B` and before `def initialize[...]
        end
      RUBY

      expect_offense(<<~RUBY)
        class Test
          extend A
          include B

          CONSTANT = 1

          def initialize
            {foo: "bar"}
          end

          private

          def foo
            "foo"
          end

          def self.bar
          ^^^^^^^^^^^^ public_class_method should come after `CONSTANT = 1` and before `def initialize[...]
            "bar"
          end
        end
      RUBY
    end
  end

  context 'given NO out of order expression' do
    it 'registers NO offense' do
      expect_no_offenses(<<~RUBY)
        class Test
          extend A
          include B

          CONSTANT = 1

          def initialize
            {foo: "bar"}
          end
        end
      RUBY

      expect_no_offenses(<<~RUBY)
        class Test
          extend A
          include B

          CONSTANT = 1

          def self.bar
            "bar"
          end

          def initialize
            {foo: "bar"}
          end

          private

          def foo
            "foo"
          end
        end
      RUBY
    end
  end

  context 'given an unknown expression' do
    it 'ignores it' do
      expect_no_offenses(<<~RUBY)
        class Test
          extend A
          include B

          def initialize
            {foo: "bar"}
          end

          # unknown expression
          foo = "bar"
        end
      RUBY
    end
  end
end
