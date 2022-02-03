describe 'Github addon - template' do
  it 'creates the PULL_REQUEST_TEMPLATE file' do
    expect(file('.github/PULL_REQUEST_TEMPLATE.md')).to exist
  end

  it 'creates Github actions workflows' do
    expect(file('.github/workflows/deploy_heroku.yml')).to exist
    expect(file('.github/workflows/publish_wiki.yml')).to exist
    expect(file('.github/workflows/review_code.yml')).to exist
    expect(file('.github/workflows/test_production_build.yml')).to exist
    expect(file('.github/workflows/test.yml')).to exist
  end

  it 'creates Github wiki structure' do
    expect(file('.github/wiki/_Sidebar.md')).to exist
    expect(file('.github/wiki/_Footer.md')).to exist
    expect(file('.github/wiki/Home.md')).to exist
    expect(file('.github/wiki/assets/images/.keep')).to exist
  end

  # TODO: Can't test this as it is now ignored by `.dockerignore`
  xit 'modifies the README.md' do
    expect(file('README.md')).to contain('## Documentation')

    expect(file('README.md')).not_to contain('## Getting Started')
    expect(file('README.md')).not_to contain('## Testing')
    expect(file('README.md')).not_to contain('## CI/CD')
  end

  describe '.github/wiki/Getting-Started.md' do
    it 'exists' do
      expect(file('.github/wiki/Getting-Started.md')).to exist
    end

    it 'contains the correct content extracted from README.md' do
      expect(file('.github/wiki/Getting-Started.md')).to contain('### Prerequisites')
      expect(file('.github/wiki/Getting-Started.md')).to contain('### Docker')
      expect(file('.github/wiki/Getting-Started.md')).to contain('### Development')
    end
  end

  describe '.github/wiki/Authentication.md' do
    it 'exists' do
      expect(file('.github/wiki/Authentication.md')).to exist
    end
  end

  describe '.github/wiki/CI-CD.md' do
    it 'exists' do
      expect(file('.github/wiki/CI-CD.md')).to exist
    end

    it 'contains the correct content extracted from the workflow README.md' do
      expect(file('.github/wiki/CI-CD.md')).to contain('## Test workflow')
      expect(file('.github/wiki/CI-CD.md')).to contain('## Test production build workflow')
      expect(file('.github/wiki/CI-CD.md')).to contain('## Deploy to Heroku workflow')
      expect(file('.github/wiki/CI-CD.md')).to contain('## Publish to Wiki workflow')
    end

    it 'deletes the workflow README.md' do
      expect(file('.github/workflow/README.md')).not_to exist
    end
  end

  describe '.github/wiki/Testing.md' do
    it 'exists' do
      expect(file('.github/wiki/Testing.md')).to exist
    end

    it 'contains the correct content extracted from README.md' do
      expect(file('.github/wiki/Testing.md')).to contain('### Docker-based tests on the CI server')
      expect(file('.github/wiki/Testing.md')).to contain('### Test')
      expect(file('.github/wiki/Testing.md')).to contain('### Automated Code Review Setup')
    end
  end
end
