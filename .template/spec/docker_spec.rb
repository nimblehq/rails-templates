describe 'Dockerfile' do
  describe package('nodejs') do
    it { should be_installed }
  end

  describe package('yarn') do
    it { should be_installed }
  end

  xdescribe port(80) do
    it { should be_listening.with('tcp') }
  end
end
