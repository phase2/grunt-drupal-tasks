module.exports = function(grunt) {

  /**
   * Define "Compass" tasks.
   *
   * Dynamically adds Compass compile tasks based on configuration sets in the
   * package.json file.
   *
   * Example:
   *
   * "themes": {
   *   "viking": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/viking",
   *     "compass": true
   *   },
   *   "spartan": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/spartan",
   *     "compass": {
   *       "environment": "development",
   *       "sourcemap": true
   *     }
   *   },
   *   "trojan": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/trojan"
   *   }
   * }
   */

  grunt.loadNpmTasks('grunt-contrib-compass');

  var config = grunt.config.get('config'),
    util = require('util'),
    steps = [];

  if (config.themes) {
    for (var key in config.themes) {
      if (config.themes.hasOwnProperty(key) && config.themes[key].compass) {
        var theme = config.themes[key],
          options = (theme.compass && typeof theme.compass === 'object') ? theme.compass : {};

        grunt.config(['compass', key], {
          options: util._extend({
            basePath: theme.path,
            config: theme.path + '/config.rb',
            bundleExec: true
          }, options)
        });

        steps.push('compass:' + key);

        // Integrate compass compilation with sass.
        // Does not narrow down more specific than a sass/ directory because
        // that location is subject only to the theme's config.rb.
        grunt.config(['watch', key], {
          files: [
            theme.path + '/**/*.scss'
          ],
          tasks: ['compass:' + key]
        });
      }
    }

    grunt.registerTask('compile-theme', steps);

    grunt.config('help.compile-theme', {
      group: 'Asset & Code Compilation'
    });
  }
};
