module.exports = function(grunt) {

  /**
   * Define "compass" tasks.
   *
   * Dynamically adds Compass compile tasks based on configuration sets in the
   * package.json file.
   *
   * Example:
   *   "compassConfig": {
   *     "project": {
   *       "basePath": "<%= config.buildPaths.html %>/sites/all/themes/custom/project"
   *     }
   *   }
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-contrib-compass/tasks');
  var config = grunt.config.get('config');
  if (config.compassConfig) {
    for (var key in config.compassConfig) {
      if (config.compassConfig.hasOwnProperty(key)) {
        grunt.config(['compass', key], {
          options: config.compassConfig[key]
        });
      }
    }
  }

};
