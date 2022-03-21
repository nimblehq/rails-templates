# frozen_string_literal: true

describe 'Web variant - .tool-versions' do
  subject { file('.tool-versions') }

  it 'sets the Node.JS version' do
    expect(subject).to contain('nodejs')
  end
end
