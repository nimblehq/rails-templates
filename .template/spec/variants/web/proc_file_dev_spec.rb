describe 'Web variant - Procfile.dev' do
  subject { file('Procfile.dev') }

  it 'adds a webpack process' do
    expect(subject).to contain('webpack')
  end

  it 'adds a css process' do
    expect(subject).to contain('css')
  end
end
