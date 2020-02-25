describe 'Docker image' do
  xdescribe port(80) do
    it { should be_listening.with('tcp') }
  end
end
