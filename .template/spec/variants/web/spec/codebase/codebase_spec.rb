describe 'Web variant - spec/codebase/codebase_spec.rb' do
  subject { file('spec/codebase/codebase_spec.rb') }

  it 'adds scss lint example' do
    expect(subject).to contain(scss_lint_example)
  end

  it 'adds eslint example' do
    expect(subject).to contain(eslint_example)
  end

  private

  def scss_lint_example
    <<~RUBY
      it 'does not offend stylelint' do
        expect(`yarn run stylelint ./`).to be_empty
      end
    RUBY
  end

  def eslint_example
    <<~RUBY
      it 'does not offend eslint' do
        expect(`yarn run eslint ./`).to include 'Done'
      end
    RUBY
  end
end
