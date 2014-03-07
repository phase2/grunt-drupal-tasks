module.exports = function(grunt) {

  /**
   * Define "composer" tasks.
   *
   * Dynamically adds a Composer install/update task if a composer.json file
   * exists in the project directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-composer/tasks');
  var config = grunt.config.get('config');
  if (require('fs').existsSync('./composer.json')) {
    grunt.config(['composer', 'update'], {});
  }

};
