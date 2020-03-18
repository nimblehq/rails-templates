describe '/bin template' do
  it 'creates the envsetup script' do
    expect(file('bin/envsetup.sh')).to exist
    expect(file('bin/envsetup.sh')).to be_executable
  end

  it 'creates the start script' do
    expect(file('bin/start.sh')).to exist
    expect(file('bin/start.sh')).to be_executable
  end

  it 'creates the test script' do
    expect(file('bin/test.sh')).to exist
    expect(file('bin/test.sh')).to be_executable
  end

  it 'creates the docker prepare script' do
    expect(file('bin/docker-prepare')).to exist
    expect(file('bin/docker-prepare')).to be_executable
  end

  it 'creates the assets precompile script' do
    expect(file('bin/assets-precompile')).to exist
    expect(file('bin/assets-precompile')).to be_executable
  end
end
