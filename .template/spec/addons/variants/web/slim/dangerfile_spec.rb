# frozen_string_literal: true

describe 'Slim Addon - Dangerfile' do
  subject { file('Dangerfile') }

  it 'adds slim lint' do
    expect(subject).to contain('slim_lint.lint')
  end
end
