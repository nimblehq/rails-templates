# frozen_string_literal: true

describe 'Slim Addon - Gemfile' do
  subject { file('Gemfile') }

  it 'adds slim gem' do
    expect(subject).to contain('slim')
  end

  describe 'Development + Test Environment' do
    it 'adds danger-slim_lint gem' do
      expect(subject).to contain('danger-slim_lint').after('^group :development, :test')
    end
  end
end
