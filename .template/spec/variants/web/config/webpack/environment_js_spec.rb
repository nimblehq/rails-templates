describe 'Web variant - config/webpack/environment.js' do
  subject { file('config/webpack/environment.js') }

  it 'configures the webpack' do
    expect(subject).to contain(webpack_config)
  end

  private

  def webpack_config
    <<~EOT
      const webpack = require('webpack');

      const plugins = [
        new webpack.ProvidePlugin({
          // Translations
          I18n: 'i18n-js',
        })
      ];

      environment.config.set('plugins', plugins);
    EOT
  end
end
