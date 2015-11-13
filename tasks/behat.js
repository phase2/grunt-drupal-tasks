module.exports = function(grunt) {

  /**
   * Define "behat" tasks.
   *
   * Dynamically adds Behat testing tasks based on configuration sets in the
   * Gruntconfig.json file.
   *
   * For a complete understanding of the behat task, please review CONFIG.md.
   *
   * Example:
   *   "config": {
   *     "buildPaths": {
   *       "html": "build/html"
   *     },
   *     "siteUrls": {
   *       "default": "http://dev-site.local",
   *       "subsite": "http://sub.dev-site.local"
   *     },
   *     "behat": {
   *       "subsite": {
   *          "src": "./features/subsite/*.feature",
   *          "debug": false
   *       }
   *     }
   *   }
   */
  grunt.loadNpmTasks('grunt-parallel-behat');
  var Help = require('../lib/help')(grunt);

  var config = grunt.config.get('config'),
    flags = '',
    _ = require('lodash');

  if (config.buildPaths.html && config.siteUrls) {
    for (var key in config.siteUrls) {
      if (config.siteUrls.hasOwnProperty(key)) {
        var options = {};

        // Check for per-site behat options.
        if (config.behat && config.behat[key]) {
          var siteOptions = config.behat[key];
          options = (typeof siteOptions === 'object') ? siteOptions : options;
        }

        // Support for global behat flags config.
        if (!options.flags && config.behat && config.behat.flags) {
          options.flags = config.behat.flags;
        }

        // Override with flags at runtime.
        if (grunt.option('behat_flags')) {
          options.flags = grunt.option('behat_flags');
        }

        grunt.config(['behat', 'site-' + key],
          {
            src: options.src || './test/features/**/*.feature',
            options: _.extend({
              config: './test/behat.yml',
              maxProcesses: 5,
              bin: 'vendor/bin/behat',
              debug: true,
              env: _.extend({}, process.env, {
                "BEHAT_PARAMS": "{\"extensions\": {\"Drupal\\\\DrupalExtension\": {\"drupal\": {\"drupal_root\": \"./" + config.buildPaths.html + "\"}}, \"Behat\\\\MinkExtension\": {\"base_url\": \"" + config.siteUrls[key] + "\", \"zombie\": {\"node_modules_path\": \"" + process.cwd() + "/node_modules/\"}}}}"
              })
            }, options)
          }
        );
      }
    }
  }
};
