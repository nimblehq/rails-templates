describe 'Bootstrap Addon - application.js' do
  subject { file('app/javascript/packs/application.js') }

  it 'imports bootstrap native' do
    expect(subject).to contain("import 'vendor/bootstrap';")
  end
end
