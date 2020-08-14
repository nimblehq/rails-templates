describe 'Web variant - Dangerfile' do
  subject { file('Dangerfile') }

  it 'adds slim_lint lint' do
    expect(subject).to contain('slim_lint.lint')
  end

  it 'adds eslint lint' do
    expect(subject).to contain('eslint.lint')
  end
end
