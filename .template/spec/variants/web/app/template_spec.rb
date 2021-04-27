describe 'Web variant - /app template' do
  context 'Javascript' do
    it 'creates base javascript directory' do
      expect(file('app/javascript/adapters')).to be_directory
      expect(file('app/javascript/components')).to be_directory
      expect(file('app/javascript/config')).to be_directory
      expect(file('app/javascript/helpers')).to be_directory
      expect(file('app/javascript/initializers')).to be_directory
      expect(file('app/javascript/lib')).to be_directory
      expect(file('app/javascript/screens')).to be_directory
    end

    context 'Initializers' do
      it 'creates main initializer file' do
        expect(file('app/javascript/initializers/index.js')).to exist
      end

      it 'creates I18n initializer file' do
        expect(file('app/javascript/initializers/i18n.js')).to exist
      end
    end

    context 'Screens' do
      it 'creates main screens file' do
        expect(file('app/javascript/screens/index.js')).to exist
      end
    end

    context 'packs/application.js' do
      it 'includes necessary modules' do
        expect(file('app/javascript/packs/application.js')).to contain('import \'core-js/stable\';')
        expect(file('app/javascript/packs/application.js')).to contain('import \'regenerator-runtime/runtime\';')

        expect(file('app/javascript/packs/application.js')).to contain('import \'translations/translations\';')

        expect(file('app/javascript/packs/application.js')).to contain('import \'initializers/\';')
        expect(file('app/javascript/packs/application.js')).to contain('import \'screens/\';')
      end
    end

    context 'packs/hello_typescript.ts' do
      it 'creates the default pack file for TypeScript' do
        expect(file('app/javascript/packs/hello_typescript.ts')).to exist
      end
    end
  end

  context 'Stylesheets' do
    it 'creates the _variables.scss file' do
      expect(file('app/assets/stylesheets/_variables.scss')).to exist
    end

    it 'creates the application.scss file' do
      expect(file('app/assets/stylesheets/application.scss')).to exist
    end

    it 'creates base stylesheets directory' do
      expect(file('app/assets/stylesheets/base')).to be_directory
      expect(file('app/assets/stylesheets/components')).to be_directory
      expect(file('app/assets/stylesheets/functions')).to be_directory
      expect(file('app/assets/stylesheets/layouts')).to be_directory
      expect(file('app/assets/stylesheets/mixins')).to be_directory
      expect(file('app/assets/stylesheets/screens')).to be_directory
    end

    context 'Functions' do
      it 'creates the sizing function' do
        expect(file('app/assets/stylesheets/functions/_sizing.scss')).to exist
      end
    end
  end

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

  context 'Views' do
    it 'modifies the html tag to attach the current locale' do
      expect(file('app/views/layouts/application.html.erb')).to contain("<html lang='<%= I18n.locale %>'>")
    end
  end
end
