describe 'Bootstrap Addon - application.scss' do
  subject { file('app/assets/stylesheets/application.scss') }

  it 'imports bootstrap stylesheets' do
    expect(subject).to contain("@import 'bootstrap/bootstrap'")
  end
end
