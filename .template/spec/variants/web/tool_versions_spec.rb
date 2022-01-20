describe 'Web variant - .tool-versions' do
  subject { file('.tool-versions') }

  it 'pins the nodejs version' do
    expect(subject).to contain('nodejs')
  end
end
