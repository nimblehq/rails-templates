describe 'Application' do
  it 'is listening on port 80' do
    # Config the wait time to 1 minute in case if the container has not fully started.
    wait(60).for do
      expect(port(80)).to be_listening.with('tcp')
    end
  end
end
