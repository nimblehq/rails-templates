# frozen_string_literal: true

describe 'Svgeez Addon - Gemfile' do
  subject { file('Gemfile') }

  it 'adds svgeez gem' do
    expect(subject).to contain('svgeez')
  end

  it 'adds inline_svg gem' do
    expect(subject).to contain('inline_svg')
  end
end
