describe 'Docker image' do
  it 'is listening on port 80' do
    wait(60).for do
      expect(port(80)).to be_listening.with('tcp')
    end
  end
end
