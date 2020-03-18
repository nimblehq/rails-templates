RSpec.describe Template::Application do
  subject { described_class.new('my-nimble-web') }

  describe '#humanized_name' do
    it 'returns the human-readable app name' do
      expect(subject.humanized_name).to eq('My Nimble')
    end
  end

  describe '#directory_name' do
    it 'returns the app directory name' do
      expect(subject.directory_name).to eq('my_nimble')
    end
  end

  describe '#namespace' do
    it 'returns the app namespace' do
      expect(subject.namespace).to eq('MyNimble')
    end
  end
end
