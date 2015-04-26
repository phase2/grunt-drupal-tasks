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

  var config = grunt.config.get('config'),
    _ = require('lodash'),
    steps = [],
    parallelTasks = [];

  if (config.themes) {
    grunt.loadNpmTasks('grunt-contrib-compass');
    var Help = require('../lib/help')(grunt);

    for (var key in config.themes) {
      if (config.themes.hasOwnProperty(key) && config.themes[key].compass) {
        var theme = config.themes[key],
          options = (theme.compass && typeof theme.compass === 'object') ? theme.compass : {};

        grunt.config(['compass', key], {
          options: _.extend({
            basePath: theme.path,
            config: theme.path + '/config.rb',
            bundleExec: true
          }, options)
        });

        steps.push('compass:' + key);

        // Provide a watch handler
        grunt.config(['watch', 'compass-' + key], {
          files: [
            theme.path + '/**/*.scss',
            theme.path + '/**/*.sass'
          ],
          tasks: ['compass:' + key]
        });

        // Add this watch to the parallel watch-theme task
        parallelTasks.push('watch:compass-' + key);
      }
    }

    if (parallelTasks) {
      grunt.loadNpmTasks('grunt-concurrent');
      grunt.config(['concurrent', 'watch-theme'], {
        tasks: parallelTasks,
        options: {
          logConcurrentOutput: true
        }
      });

      grunt.registerTask('watch-theme', ['concurrent:watch-theme']);
      Help.add({
        task: 'watch-theme',
        group: 'Real-time Tooling',
        description: "Watch for changes that should rebuild frontend assets, such as CSS."
      });
    }

    if (steps) {
      grunt.registerTask('compile-theme', steps);
      Help.add({
        task: 'compile-theme',
        group: 'Asset & Code Compilation',
        description: 'Run compilers for all themes (such as Compass).'
      });
    }

  }
};
