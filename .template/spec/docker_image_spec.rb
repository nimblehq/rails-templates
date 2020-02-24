describe 'Docker image' do
  it 'installs nodejs package' do
    expect(package('nodejs')).to be_install
  end

  it 'installs yarn package' do
    expect(package('yarn')).to be_install
  end

  xdescribe port(80) do
    it { should be_listening.with('tcp') }
  end
end
