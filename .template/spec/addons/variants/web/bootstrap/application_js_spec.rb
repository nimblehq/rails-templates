describe 'Bootstrap Addon - application.js' do
  subject { file('app/javascript/application.js') }

  it 'imports vendor scripts' do
    expect(subject).to contain("import 'vendor/';")
  end
end
