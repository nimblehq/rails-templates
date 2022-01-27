describe 'Github addon - template' do
  it 'creates the PULL_REQUEST_TEMPLATE file' do
    expect(file('.github/PULL_REQUEST_TEMPLATE.md')).to exist
  end

  it 'creates Github actions workflows' do
    expect(file('.github/workflows/deploy_heroku.yml')).to exist
    expect(file('.github/workflows/test_production_build.yml')).to exist
    expect(file('.github/workflows/test.yml')).to exist
  end

  it 'creates Github wiki' do
    expect(file('.github/wiki/_Sidebar.md')).to exist
    expect(file('.github/wiki/_Footer.md')).to exist

    expect(file('.github/wiki/Home.md')).to exist
    expect(file('.github/wiki/Getting-Started.md')).to exist
    expect(file('.github/wiki/CI-CD.md')).to exist
    expect(file('.github/wiki/Testing.md')).to exist

    expect(file('.github/wiki/assets/images/.keep')).to exist
  end
end
