describe '/bin template' do
  EXECUTABLE_MODE = 755

  it 'creates the envsetup script' do
    expect(file('bin/envsetup.sh')).to exist
    expect(file('bin/envsetup.sh')).to be_mode(EXECUTABLE_MODE)
  end

  it 'creates the start script' do
    expect(file('bin/start.sh')).to exist
    expect(file('bin/start.sh')).to be_mode(EXECUTABLE_MODE)
  end

  it 'creates the test script' do
    expect(file('bin/test.sh')).to exist
    expect(file('bin/test.sh')).to be_mode(EXECUTABLE_MODE)
  end
end
