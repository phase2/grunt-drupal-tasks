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
   *   "spartan": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/spartan",
   *     "compass": true
   *   },
   *   "trojan": {
   *     "path": "<%= config.srcPaths.drupal %>/themes/trojan"
   *   }
   * }
   */
  grunt.loadNpmTasks('grunt-shell');

  var config = grunt.config.get('config');
  if (config.themes) {
    var steps = []
    for (var key in config.themes) {
      if (config.themes.hasOwnProperty(key) && config.themes[key].compass) {
        var path = config.themes[key].path;
        grunt.config(['shell', 'compass-' + key], {
          command: 'bundle exec "compass compile --time --app-dir=' + path + ' --config=' + path + '/config.rb"'
        });
        steps.push('shell:compass-' + key);

        // Integrate compass compilation with sass.
        // Does not narrow down more specific than a sass/ directory because
        // that location is subject only to the theme's config.rb.
        grunt.config(['watch', 'scss-' + key], {
          files: [
            path + '/**/*.scss'
          ],
          tasks: ['shell:compass-' + key]
        });
      }
    }
    grunt.registerTask('compile-theme', steps);

    grunt.config('help.compile-theme', {
      group: 'Asset & Code Compilation'
    });
  }
};
