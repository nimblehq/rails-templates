describe 'Api variant - template' do
  context 'Controllers' do
    it 'creates the localization concern' do
      expect(file('app/controllers/concerns/localization.rb')).to exist
    end

    context 'Application controller' do
      it 'includes the localization concern' do
        expect(file('app/controllers/application_controller.rb')).to contain('include Localization')
      end
    end
  end
end
