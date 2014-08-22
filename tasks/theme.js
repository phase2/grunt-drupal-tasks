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
  grunt.loadTasks(__dirname + '/../node_modules/grunt-shell/tasks');

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
      }
    }
    grunt.registerTask('compile-theme', steps);
  }
};
