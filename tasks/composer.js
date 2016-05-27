module.exports = function(grunt) {

  /**
   * Define "composer" tasks.
   *
   * Dynamically adds a Composer install task if a composer.json file
   * exists in the project directory.
   */
  var config = grunt.config.get('config');
  if (require('fs').existsSync('./composer.json')) {
    grunt.loadNpmTasks('grunt-composer');
    var Help = require('../lib/help')(grunt);

    grunt.config(['composer', 'install'], {
      options: {
        flags: [
          'no-interaction',
          'no-progress',
          'prefer-dist'
        ],
      }
    });
    grunt.config(['composer', 'update'], {
      options: {
        flags: [
          'no-interaction',
          'no-progress',
          'prefer-dist'
        ],
      }
    });

    Help.add({
      task: 'composer',
      group: 'Dependency Management',
      description: 'Install dependencies defined in this project\'s composer.json file.'
    });
  }
};
