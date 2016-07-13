module.exports = function(grunt) {
  /**
   * Define "compile-theme" task.
   *
   * Individual themes "register" with grunt by adding a configuration object
   * the themes section of configuration. Each theme may specify a non-default
   * path. From there they may specify commands that should be passed to scripts
   * provided with the theme.
   *
   * Example:
   *
   * "themes": {
   *   // Legionare relies on the default path and attaches a task to our
   *   // `compile-theme` task.
   *   "legionaire": {
   *     "scripts": {
   *       "compile-theme": "grunt compile"
   *     }
   *   },
   *   // Gladiator specifies a path and a validate task to be run by
   *   // `grunt themes:gladiator:validate`.
   *   "gladiator": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/gladiator",
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
  var config = grunt.config.get('config');
  var steps = [];

  if (config.themes) {
    var Help = require('../lib/help')(grunt);

    for (var key in config.themes) {
      if (config.themes.hasOwnProperty(key)) {
        var theme = config.themes[key];

        // If the compile-theme delegation script is truthy trigger it as part
        // of the compile theme task. This ensures developers not working
        // directly with the theme and CI systems can still use the primary
        // grunt implementation as a single authority for the build process.
        if (theme.scripts && theme.scripts['compile-theme']) {
          steps.push('themes:' + key + ':compile-theme');
        }
      }
    }

    if (steps) {
      grunt.registerTask('compile-theme', steps);
      Help.add({
        task: 'compile-theme',
        group: 'Asset & Code Compilation',
        description: 'Run compilers for all themes.'
      });
    }

    // Register a passthru task that calls out to theme-specific Grunt tooling.
    grunt.registerTask('themes', 'Proxies tasks to theme-specific, pre-defined command-line operations.', function() {
      var themes = grunt.config('config.themes');
      if (!this.args[0]) {
        var _ = require('lodash');
        _.each(themes, function(theme, key) {
          grunt.log.writeln(key + ' (' + theme.path + ')');
        });
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
