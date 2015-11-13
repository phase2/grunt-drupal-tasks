module.exports = function(grunt) {

  grunt.config('test', {
    behat: true,
    drupal: []
  });

  grunt.config(['shell', 'testdrupal'], {
    // @todo Only make this available on Drupal 8+, or change command.
    // @todo Make configurable.
    // @todo The phpunit binary (./vendor/bin/phpunit) needs to be executable, GDT changes this somehow during build.
    // @todo Need to incorporate actual site URL in this command.
    command: 'php ./core/scripts/run-tests.sh --verbose --color --concurrency 4 --directory ./modules/custom',
    options: {
      execOptions: {
        cwd: '<%= config.buildPaths.html %>'
      }
    }
  });

  // @todo Would rather display as 'alias for test:behat, test:drupal, etc'.
  grunt.registerMultiTask('test', 'Run all configured tests.', function(args) {
    var self = this;
    switch (self.target) {
      case 'behat':
        grunt.task.run('behat');
        break;

      case 'drupal':
        grunt.task.run('shell:testdrupal');
    }
  });

  Help.add({
    task: 'test',
    group: 'Testing & Code Quality',
    description: 'Run custom module and Behat tests included with this project.'
  });
}
