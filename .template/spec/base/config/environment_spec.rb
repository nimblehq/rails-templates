describe 'config/environment.rb' do
  subject { file('config/environment.rb') }

  it 'requires the modules in the lib folder' do
    expect(subject).to contain("Dir[Rails.root.join('lib', #{template_application.directory_name}, '**', '*.rb')].sort.each { |f| require f }")
  end
end
