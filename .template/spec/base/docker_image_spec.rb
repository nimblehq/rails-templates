describe 'Docker image' do
  it 'is listening on port 80' do
    expect(port(80)).to be_listening.with('tcp')
  end
end
