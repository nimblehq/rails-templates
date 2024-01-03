# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'
require_relative '../required_inverse_of_relations'

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
    it 'do NOT register any offenses' do
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
end
