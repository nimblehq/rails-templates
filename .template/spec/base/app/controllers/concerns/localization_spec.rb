# frozen_string_literal: true

describe 'localization concern' do
  subject { file('app/controllers/concerns/localization.rb') }

  it 'contains the around_action' do
    expect(subject).to contain('around_action :switch_locale')
  end
end
