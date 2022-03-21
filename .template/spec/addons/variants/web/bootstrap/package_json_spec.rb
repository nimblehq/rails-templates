# frozen_string_literal: true

describe 'Bootstrap addon - package.json' do
  subject do
    JSON.parse(file('package.json').content)
  end

  describe 'Dependencies' do
    it 'adds bootstrap dependency' do
      expect(subject['dependencies']).to include('bootstrap')
    end

    it 'adds @popperjs/core dependency' do
      expect(subject['dependencies']).to include('@popperjs/core')
    end
  end
end
