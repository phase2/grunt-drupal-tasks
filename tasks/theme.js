module.exports = function(grunt) {

  /**
   * Define "compile-theme" task.
   *
   * Individual themes "register" with grunt by adding a configuration object
   * the themes section of configuration. Each theme may specify a non-default path.
   * From there they may opt-in for compass compilation, or specify via the proxy
   * behavior that grunt-drupal-tasks should outsource theme handling commands
   * to tooling shipped in the theme.
   *
   * Example:
   *
   * "themes": {
   *   // Viking specifies a path and enables compass compilation.
   *   "viking": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/viking",
   *     "compass": true
   *   },
   *   // Spartan specifies a path and enables compass compilation with options.
   *   "spartan": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/spartan",
   *     "compass": {
   *       "environment": "development",
   *       "sourcemap": true
   *     }
   *   },
   *   // Legionare relies on the default path and attaches a task to our
   *   // `compile-theme` task.
   *   "legionaire": {
   *     "scripts": {
   *       "compile-theme": "grunt compile"
   *     }
   *   },
   *   // Gladiator specifies a path, enables compass compilation by GDT, and
   *   // specifies a validate task to be run by `grunt themes:gladiator:validate`.
   *   "gladiator": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/gladiator",
   *     "compass": true,
   *     "scripts": {
   *       "validate": "gulp eslint",
   *     }
   *   },
   *   // Trojan does not specify a path or define functionality. It is a stub
   *   // the system will recognize and list as part of `grunt themes`.
   *   "trojan": {
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

        if (config.themes[key].compass) {
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

        // If the compile-theme delegation script is truthy trigger it as part of the
        // compile theme task. This ensures developers not working directly with the
        // theme and CI systems can still use the primary grunt implementation as a
        // single authority for the build process.
        if (theme.scripts && theme.scripts['compile-theme']) {
          steps.push('themes:' + key + ':compile-theme');
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
    grunt.registerTask('themes', 'Proxies tasks to theme-specific, pre-defined command-line operations.', function() {
      var themes = grunt.config('config.themes');
      if (!this.args[0]) {
        for (key in themes) {
          grunt.log.writeln(key + ' (' + themes[key].path + ')');
        }
        return;
      }

      var theme = this.args[0];
      this.requiresConfig(['config', 'themes', theme, 'path']);
      var scripts = require('../lib/scripts')(grunt);
      var task = scripts.handle(themes[theme], this.args[1], 'theme');

      if (task) {
        grunt.task.run(task);
      }
    });

    Help.add({
      task: 'themes',
      group: 'Utilities'
    });

  }
};
