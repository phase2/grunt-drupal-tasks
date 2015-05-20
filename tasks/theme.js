module.exports = function(grunt) {

  /**
   * Define "compile-theme" task.
   *
   * Individual themes "register" with grunt by adding a configuration object
   * the themes section of configuration. Each theme should have at least a path.
   * From there they may opt-in for compass compilation, or specify via the proxy
   * behavior that grunt-drupal-tasks should outsource theme handling commands
   * to tooling shipped with the theme.
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
   *   "legionaire": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/legionaire",
   *     "proxy": true
   *   },
   *   "gladiator": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/gladiator",
   *     "proxy": {
   *       "compile-theme": "grunt build",
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
      if (config.themes.hasOwnProperty(key)) {
        var theme = config.themes[key];
        if (!theme.proxy && config.themes[key].compass) {
          var options = (theme.compass && typeof theme.compass === 'object') ? theme.compass : {};

          grunt.config(['compass', key], {
            options: _.extend({
              basePath: theme.path,
              config: theme.path + '/config.rb',
              bundleExec: true
            }, options)
          });

          task = 'compass:' + key;
          steps.push(task);

          // Provide a watch handler
          grunt.config(['watch', 'compass-' + key], {
            files: [
              theme.path + '/**/*.scss',
              theme.path + '/**/*.sass'
            ],
            tasks: [task]
          });

          // Add this watch to the parallel watch-theme task
          parallelTasks.push('watch:compass-' + key);
        }

        // If the proxy property is truthy let's add a callout to it as part of compile-theme.
        // This is important to ensure the grunt-drupal-tasks `grunt compile-theme` is complete
        // for purposes like continuous integration.
        if (theme.proxy) {
          // If the proxy property is an object with the "compile-theme" property use that.
          // Otherwise we default to 'grunt compile' as an emergent practice.
          var command = theme.proxy.'compile-theme' || 'grunt compile';
          steps.push('theme:' + key + ':' + command);
        }
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

    // Register a passthru task that can call out to theme-specific Grunt tooling.
    grunt.registerTask('theme', 'Proxies work to the theme-specific Grunt configuration.', function(theme, task) {
      // Fail if this is requested on behalf of a theme without proxying enabled or a path.
      this.requiresConfig(['config', 'themes', theme, 'proxy'], ['config', 'themes', theme, 'path']);

      var path = grunt.config(['config', 'themes', theme, 'path']);
      grunt.config(['shell', 'theme-dispatch'], {
        command: task,
        options: {
          execOptions: {
            cwd: path
          }
        }
      });
      grunt.task.run('shell:theme-dispatch');
    });

  }
};
