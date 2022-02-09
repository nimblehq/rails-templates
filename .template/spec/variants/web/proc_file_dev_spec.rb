describe 'Web variant - Procfile.dev' do
  subject { file('Procfile.dev') }

  it 'adds a js process' do
    expect(subject).to contain('js')
  end

  it 'adds a css process' do
    expect(subject).to contain('css')
  end
end
