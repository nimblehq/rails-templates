describe 'Bootstrap addon - package.json' do
  subject do
    JSON.parse(file('package.json').content)
  end

  describe 'Dependencies' do
    it 'adds bootstrap.native dependency' do
      expect(subject['dependencies']).to include('bootstrap.native')
    end
  end
end
