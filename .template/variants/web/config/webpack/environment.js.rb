# Add i18n-js plugin to webpack
insert_into_file 'config/webpack/environment.js', after: %r{const { environment } = require\('@rails/webpacker'\)\n} do
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
