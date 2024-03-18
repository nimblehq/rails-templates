# frozen_string_literal: true

describe 'Bootstrap Addon - application.scss' do
  subject { file('app/assets/stylesheets/application.scss') }

  it 'imports vendor stylesheets' do
    expect(subject).to contain("@import 'vendor';")
  end
end
