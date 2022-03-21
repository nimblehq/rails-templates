# frozen_string_literal: true

describe 'Web variant - Dangerfile' do
  subject { file('Dangerfile') }

  it 'adds eslint lint' do
    expect(subject).to contain('eslint.lint')
  end
end
