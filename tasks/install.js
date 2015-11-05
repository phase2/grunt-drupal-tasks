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

  var Help = require('../lib/help')(grunt),
    Drupal = require('../lib/drupal')(grunt);

  var path = require('path'),
    _ = require('lodash');

  // If no path is configured for Drush, fallback to the system path.
  var cmd = {cmd: Drupal.drushPath()};

  var profile = grunt.config('config.project.profile') || 'standard';

  var dbUrl = grunt.option('db-url') || false;
  if (dbUrl) {
    dbUrl = '--db-url=' + dbUrl;
  }

  grunt.config(['drush', 'install'], {
    args: ['site-install', '-yv', profile, dbUrl],
    options: _.extend({
      cwd: '<%= config.buildPaths.html %>'
    }, cmd)
  });
  grunt.config(['drush', 'sql-drop'], {
    args:['sql-drop', '-y'],
    options: _.extend({
      cwd: '<%= config.buildPaths.html %>'
    }, cmd)
  });
  grunt.config(['shell', 'loaddb'], {
    command: 'gzip -dc <%= config.project.db %> | <%= config.project.dbConnection %>'
  });

  grunt.registerTask('install', 'Install Drupal with the configured profile, or from a database dump file if one exists.', function() {

    var done = this.async();

    // Check for a database file first.
    var dbPath = grunt.config('config.project.db');
    if (dbPath && grunt.file.exists(dbPath)) {
      Drupal.loadDatabaseConnection(function(error) {
        if (error) {
          grunt.fail.fatal(error);
          done();
        }
        grunt.task.run([
          // Drop current database.
          'drush:sql-drop',
          // Load new database.
          'shell:loaddb',
          // Run any pending database updates.
          'drush:updb'
        ]);
        done();
      });
    }
    else {
      grunt.task.run([
        // Run site install.
        'drush:install'
      ]);
      done();
    }
  });

  Help.add([
    {
      task: 'install',
      group: 'Operations'
    },
  ]);
};
