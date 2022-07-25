# frozen_string_literal: true

describe 'Hotwire Addon - Gemfile' do
  subject { file('Gemfile') }

  it 'adds turbo-rails gem' do
    expect(subject).to contain('turbo-rails')
  end

  it 'adds stimulus-rails gem' do
    expect(subject).to contain('stimulus-rails')
  end
end
