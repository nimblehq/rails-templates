// Karma configuration
// TODO: Enable if the project use webpack to bundle app assets
// const webpackConfig = require('./config/webpack/test.js');

module.exports = function(config) {
  config.set({
    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',

    // frameworks to use
    // Please add `jasmine-jquery` for jquery support
    frameworks: ['jasmine-jquery', 'jasmine'],

    plugins: [
      // TODO: Enable if the project use webpack to bundle app assets
      // 'karma-webpack',
      'karma-jquery',
      'karma-jasmine-jquery',
      'karma-html2js-preprocessor',
      'karma-jasmine',
      'karma-chrome-launcher',
      'karma-spec-reporter'
    ],

    // list of files / patterns to load in the browser
    files: [
      'spec/javascripts/**/*Spec.js',
      'app/assets/javascripts/**/spec.js',

      { pattern: 'spec/javascripts/fixtures/*.html', watch: true, served: true }
    ],

    // list of files / patterns to exclude
    exclude: [
    ],

    // TODO: Enable if the project use webpack to bundle app assets
    // webpack: webpackConfig,

    // preprocess matching files before serving them to the browser
    preprocessors: {
      // TODO: Enable if the project use webpack to bundle app assets
      // 'spec/javascripts/**/*Spec.js': ['webpack'],
      // 'assets/javascripts/**/spec.js': ['webpack'],
      'spec/javascripts/fixtures/*.html': ['html2js']
    },

    reporters: ['spec'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome', 'ChromeHeadless'],
    singleRun: true,
    concurrency: Infinity
  });
};
