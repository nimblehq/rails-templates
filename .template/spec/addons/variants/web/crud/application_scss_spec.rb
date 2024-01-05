# frozen_string_literal: true

describe 'CRUD Addon - application.scss' do
  subject { file('app/assets/stylesheets/application.scss') }

  it 'imports layouts stylesheets' do
    expect(subject).to contain("@import 'layouts';")
  end
end
