# frozen_string_literal: true

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

    it 'creates build script' do
      expect(file('app/javascript/build.js')).to exist
    end

    context 'Entry file' do
      it 'creates javascript entry file' do
        expect(file('app/javascript/application.js')).to exist
      end

      it 'loads the javascript entry file in the layout' do
        expect(file('app/views/layouts/application.html.erb')).to contain('<%= javascript_include_tag "application"')
      end

      it 'imports necessary modules' do
        expect(file('app/javascript/application.js')).to contain('import \'./translations/translations\';')

        expect(file('app/javascript/application.js')).to contain('import \'./initializers/\';')
        expect(file('app/javascript/application.js')).to contain('import \'./screens/\';')
      end
    end

    context 'Global file' do
      it 'creates javascript global file' do
        expect(file('app/javascript/global.js')).to exist
      end

      it 'exports necessary global modules' do
        expect(file('app/javascript/global.js')).to contain('I18n')
      end
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

  context 'Assets Builds' do
    it 'creates the app/assets/builds/.keep file' do
      expect(file('app/assets/builds/.keep')).to exist
    end
  end

  context 'I18n' do
    it 'creates the translation.js file' do
      expect(file('app/javascript/translations/translations.js')).to exist
    end

    it 'creates the localization concern' do
      expect(file('app/controllers/concerns/localization.rb')).to exist
    end

    it 'includes the localization concern in the application controller' do
      expect(file('app/controllers/application_controller.rb')).to contain('include Localization')
    end

    it 'modifies the html tag to attach the current locale' do
      expect(file('app/views/layouts/application.html.erb')).to contain("<html lang='<%= I18n.locale %>'>")
    end
  end
end
