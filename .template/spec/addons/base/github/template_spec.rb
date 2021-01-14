describe 'Github addon - template' do
  it 'creates the PULL_REQUEST_TEMPLATE file' do
    expect(file('.github/PULL_REQUEST_TEMPLATE.md')).to exist
  end

  it 'creates Github actions workflows' do
    expect(file('.github/workflows/deploy_heroku.yml')).to exist
    expect(file('.github/workflows/test_production_build.yml')).to exist
    expect(file('.github/workflows/test.yml')).to exist
  end
end
