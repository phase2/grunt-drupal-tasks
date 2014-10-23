module.exports = function(grunt) {

  /**
   * Define "composer" tasks.
   *
   * Dynamically adds a Composer install task if a composer.json file
   * exists in the project directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-composer/tasks');
  var config = grunt.config.get('config');
  if (require('fs').existsSync('./composer.json')) {
    grunt.config(['composer', 'install'], {});
    grunt.config('help.composer', {
      group: 'Dependency Management',
    });
  }
};
