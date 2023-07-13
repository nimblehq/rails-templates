# frozen_string_literal: true

describe 'SVG Sprite Addon - Gemfile' do
  subject { file('Gemfile') }

  it 'adds svg sprite gem' do
    expect(subject).to contain('svg_sprite')
  end
end
