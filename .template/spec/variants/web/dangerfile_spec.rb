# frozen_string_literal: true

describe 'Web variant - Dangerfile' do
  subject { file('Dangerfile') }

  it 'adds eslint lint' do
    expect(subject).to contain('eslint.lint')
  end

  it 'adds stylelint lint' do
    expect(subject).to contain('stylelint.lint')
  end
end
