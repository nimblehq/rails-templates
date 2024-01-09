# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../cops/required_inverse_of_relations'

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense
end

describe CustomCops::RequiredInverseOfRelations, :config do
  context 'given an association expression without :inverse_of option' do
    it 'registers an offense' do
      expect_offense(<<~RUBY)
        class Test
          has_many :books
          ^^^^^^^^^^^^^^^ Use inverse_of option when defining associations to prevent avoidable SQL queries and keep models in sync.
        end
      RUBY

      expect_offense(<<~RUBY)
        class Test
          belongs_to :books
          ^^^^^^^^^^^^^^^^^ Use inverse_of option when defining associations to prevent avoidable SQL queries and keep models in sync.
        end
      RUBY
    end
  end

  context 'given an association expression with :inverse_of option' do
    it 'registers NO offenses' do
      expect_no_offenses(<<~RUBY)
        class Test
          has_many :books, inverse_of: :author
        end
      RUBY

      expect_no_offenses(<<~RUBY)
        class Test
          belongs_to :author, inverse_of: :books
        end
      RUBY
    end
  end

  context 'given a method which have the same name with one of Rails association helpers' do
    context 'given the method invocation has explicit module/class' do
      it 'registers NO offenses' do
        expect_no_offenses(<<~RUBY)
          class Test
            def test
              Module.has_many :books
            end
          end
        RUBY
      end
    end

    context 'given the method invocation has explicit receiver' do
      it 'registers NO offenses' do
        expect_no_offenses(<<~RUBY)
          class Test
            def test
              self.has_many :books
            end
          end
        RUBY
      end
    end
  end
end
