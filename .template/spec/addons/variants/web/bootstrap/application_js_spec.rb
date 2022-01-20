describe 'Bootstrap Addon - application.js' do
  subject { file('app/javascript/packs/application.js') }

  it 'imports vendor scripts' do
    expect(subject).to contain("import 'vendor/';")
  end
end
