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

      var script = Drupal.majorVersion() == 7 ? './scripts/run-tests.sh' : './core/scripts/run-tests.sh';
      var testLocation = Drupal.majorVersion() == 7 ? './sites/all/modules/custom' : './modules/custom';
      var domain = process.env.GDT_DOMAIN || grunt.config('config.domain') || require('os').hostname();

      grunt.config(['shell', 'testdrupal'], {
        command: grunt.config.get('config.testing.drupal.command') || 'php ' + script + ' --verbose --color --concurrency 4 --directory ' + testLocation + ' --url ' + domain,
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
