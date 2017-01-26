module.exports = function(grunt) {
  /**
   * Define "composer" tasks.
   *
   * Dynamically adds a Composer install task if a composer.json file
   * exists in the project directory.
   */
  if (require('fs').existsSync('./composer.json')) {
    grunt.loadNpmTasks('grunt-composer');
    var Help = require('../lib/help')(grunt);

    grunt.config(['composer', 'install'], {
      options: {
        flags: [
          'no-interaction',
          'no-progress',
          'prefer-dist'
        ]
      }
    });
    grunt.config(['composer', 'update'], {
      options: {
        flags: [
          'no-interaction',
          'no-progress',
          'prefer-dist'
        ]
      }
    });

    var composer = JSON.parse(require('fs').readFileSync('./composer.json', 'utf8'));
    if (typeof composer.scripts !== 'undefined' && 'drupal-scaffold' in composer.scripts) {
      // Add the drupal-scaffold task if it is defined in the `composer.json`.
      grunt.config(['composer', 'drupal-scaffold'], {});
    }
    if (typeof composer.scripts !== 'undefined' && 'test' in composer.scripts) {
      // Add the composer test task.
      grunt.config(['composer', 'test'], {});
    }

    Help.add({
      task: 'composer',
      group: 'Dependency Management',
      description:
        "Install dependencies defined in this project's composer.json file."
    });
  }
};
