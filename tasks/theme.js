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
    steps = [],
    watch = [];

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
        grunt.config(['watch', 'compass-' + key], {
          files: [
            theme.path + '/**/*.scss'
          ],
          tasks: ['compass:' + key]
        });

        watch.push('watch:compass-' + key);
      }
    }

    grunt.config(['parallel', 'watch-theme'], {
      options: {
        stream: true
      },
      tasks: [
        {
          grunt: true,
          args: watch
        }
      ]
    });

    grunt.registerTask('compile-theme', steps);
    grunt.registerTask('watch-theme', ['parallel:watch-theme']);

    grunt.config('help.compile-theme', {
      group: 'Asset & Code Compilation',
      description: 'Run compilers for the theme, such as Compass.'
    });
    grunt.config('help.watch-theme', {
      group: 'Real-time Tooling',
      description: "Watch for changes that should rebuild frontend assets, such as CSS."
    });
  }
};
