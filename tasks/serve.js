module.exports = function(grunt) {
  /**
   * Define tasks to quickly get Drupal running.
   *
   * grunt serve
   *   Run Drupal via the PHP webserver and activate watch tasks.
   * grunt serve:demo
   *   Run Drupal via the PHP webserver without running watch tasks.
   * grunt serve:test
   *   Run Drupal via the PHP webserver without running watch tasks or opening
   *   the browser.
   */
  grunt.loadNpmTasks('grunt-drush');

  var Help = require('../lib/help')(grunt);
  var Drupal = require('../lib/drupal')(grunt);

  var path = require('path');
  var _ = require('lodash');

  // If no path is configured for Drush, fallback to the system path.
  var cmd = {cmd: Drupal.drushPath()};

  var profile = grunt.config('config.project.profile') || 'standard';

  grunt.config(['drush', 'liteinstall'], {
    args: ['site-install', '-yv', profile, '--db-url=sqlite:/' +
      path.join(path.resolve(grunt.config('config.buildPaths.build')),
      'drupal.sqlite')],
    options: _.extend({
      cwd: '<%= config.buildPaths.html %>'
    }, cmd)
  });

  grunt.config(['drush', 'serve'], {
    args: ['runserver', ':' + (grunt.config('config.serve.port') || 8080)],
    options: _.extend({
      cwd: '<%= config.buildPaths.html %>'
    }, cmd)
  });

  grunt.registerTask('serve', 'Run Drupal using the PHP built-in webserver. ' +
    'Use serve:demo to run without watch tasks. Use serve:test for G-D-T ' +
    'development.', function() {
      if (this.args[0] !== 'test') {
        // Unlike the test version, this one allows port overriding and opens
        // the site in a new tab.
        grunt.config('drush.serve.args', ['runserver', ':' +
          (grunt.config('config.serve.port') || 8080) + '/']);
      }

      if (this.args.length) {
        grunt.task.run('drush:serve');
      } else {
        grunt.loadNpmTasks('grunt-concurrent');

        // Allow overriding the tasks run concurrently to the Drupal server.
        var serveTasks = grunt.config('config.serve.concurrent');
        if (!serveTasks) {
          serveTasks = ['watch-test'];
          if (grunt.task.exists('watch-theme')) {
            serveTasks.push('watch-theme');
          }
        }
        serveTasks.push('drush:serve');

        grunt.config('concurrent.serve', {
          tasks: serveTasks,
          options: {
            logConcurrentOutput: true
          }
        });

        grunt.task.run('concurrent:serve');
      }
    });

  Help.add([
    {
      task: 'serve',
      group: 'Operations'
    }
  ]);
};
