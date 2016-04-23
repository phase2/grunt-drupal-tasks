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

    grunt.config(['composer', 'drupal-install'], {
      options: {
        flags: [
          'no-interaction',
          'no-progress',
          'prefer-dist'
        ],
        cwd: 'build/html'
      }
    });

    Help.add({
      task: 'composer:install',
      group: 'Dependency Management',
      description: 'Install development dependencies defined in this project\'s composer.json file.'
    });
  }

  grunt.registerTask('composer-drupal', 'Install Drupal dependencies and update autoloader.', function() {
    grunt.task.requires('drushmake:default');
    grunt.task.requires('scaffold');

    var done = this.async();
    var drupal = require('../lib/drupal')(grunt);
    drupal.loadDrushStatus(function (err, status) {
      if (err) {
        grunt.fail.fatal('Cannot load Drush status for built Drupal docroot.\n\n' + err);
      }
      else if (require('semver').gte(status['drupal-version'], '8.1')) {
        grunt.task.run('composer:drupal-install');
      }
      done();
    });
  });
};
