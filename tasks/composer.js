module.exports = function(grunt) {

  /**
   * Define "composer" tasks.
   *
   * Dynamically adds a Composer install task if a composer.json file
   * exists in the project directory.
   */
  grunt.loadNpmTasks('grunt-composer');
  var config = grunt.config.get('config');
  if (require('fs').existsSync('./composer.json')) {
    grunt.config(['composer', 'install'], {});
    grunt.config('help.composer', {
      group: 'Dependency Management',
      description: 'Install dependencies defined in this project\'s composer.json file.'
    });
  }
};
