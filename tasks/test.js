module.exports = function(grunt) {

  var Drupal = require('../lib/drupal')(grunt);
  var Help = require('../lib/help')(grunt);

  grunt.config('test', {
    behat: true,
    drupal: {
      command: []
    }
  });

  // @todo Would rather display as 'alias for test:behat, test:drupal, etc'.
  grunt.registerMultiTask('test', 'Run all configured tests.', function(args) {
    var self = this;
    var done = this.async();

    Drupal.loadDrushStatus(function(err) {
      if (err) {
        grunt.fail.fatal('Cannot load Drush status for built Drupal docroot.\n\n');
        return done();
      }

      // Only run Drupal tests on D8 and higher. For D7, there is no option to run tests in a directory, so projects
      // wishing to do this would add a separate task and hard-code the test groups that need to run.
      var majorVersion = Drupal.majorVersion();
      if (majorVersion != 8 && self.target == 'drupal') {
        grunt.verbose.write('Running Drupal tests by directory is unsupported in Drupal 7. Create a custom task to run test groups as needed.');
        return done();
      }

      var script = './core/scripts/run-tests.sh';
      var testLocation = './modules/custom';
      var domain = process.env.GDT_DOMAIN || grunt.config('config.domain') || require('os').hostname();

      grunt.loadNpmTasks('grunt-shell');
      grunt.config(['shell', 'testdrupal'], {
        command: grunt.config.get('config.testing.drupal.command') || 'php ' + script + ' --verbose --color --concurrency 4 --directory ' + testLocation + ' --url ' + domain + ' --php `which php`',
        options: {
          execOptions: {
            cwd: '<%= config.buildPaths.html %>'
          }
        }
      });

      switch (self.target) {
        case 'behat':
          grunt.task.run('behat');
          break;

        case 'drupal':
          grunt.task.run('shell:testdrupal');
          break;
      }

      done();
    });

  });

  Help.add({
    task: 'test',
    group: 'Testing & Code Quality',
    description: 'Run custom module and Behat tests included with this project.'
  });
}
