# frozen_string_literal: true

describe 'Svgeez Addon - Gemfile' do
  subject { file('Gemfile') }

  it 'adds svgeez gem' do
    expect(subject).to contain('svgeez')
  end
end
