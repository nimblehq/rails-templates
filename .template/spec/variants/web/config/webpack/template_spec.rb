describe 'Web variant - /config/webpack template' do
  it 'configures the webpack compilation in test environment to false' do
    expect(file('config/webpacker.yml')).to contain("compile: false").from(/^test:$/).to(/^production:$/)
  end
end
