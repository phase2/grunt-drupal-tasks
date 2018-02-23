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
   *       "flags": "--tags ~@wip",
   *       "path": "/usr/local/bin/behat",
   *       "subsite": {
   *          "src": "./features/subsite/*.feature",
   *          "debug": false
   *       }
   *     }
   *   }
   *
   * If the command line option `--behat_flags="flags"` is set, the `flags`
   * specified will be passed to behat and override any flags from the config.
   */
  grunt.loadNpmTasks('grunt-parallel-behat');
  var config = grunt.config.get('config');
  var _ = require('lodash');

  if (config.buildPaths.html && config.siteUrls) {
    for (var key in config.siteUrls) {
      if (config.siteUrls.hasOwnProperty(key)) {
        var options = {};
        var path = 'vendor/bin/behat';

        // Allow configuring the path to the behat binary.
        if (config.behat && config.behat.path) {
          path = config.behat.path;
        }

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
              bin: path,
              debug: true,
              env: _.extend({}, process.env, {
                BEHAT_PARAMS: "{\"extensions\": {\"Drupal\\\\DrupalExtension\": {\"drupal\": {\"drupal_root\": \"./" + config.buildPaths.html + "\"}}, \"Behat\\\\MinkExtension\": {\"base_url\": \"" + config.siteUrls[key] + "\"}}}"
              })
            }, options)
          }
        );
      }
    }
  }
};
