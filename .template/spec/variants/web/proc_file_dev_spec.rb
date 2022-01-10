describe 'Web variant - Procfile.dev' do
  subject { file('Procfile.dev') }

  it 'adds a webpack process' do
    expect(subject).to contain('webpack')
  end
end
