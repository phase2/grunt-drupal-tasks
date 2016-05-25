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

  var _ = require('lodash');

  // If no path is configured for Drush, fallback to the system path.
  var cmd = {cmd: Drupal.drushPath()};
  var args = ['--root=<%= config.buildPaths.html %>'];
  var profile = grunt.config('config.project.profile') || 'standard';
  var dbUrl = grunt.option('db-url') || '';

  if (dbUrl) {
    dbUrl = '--db-url=' + dbUrl;
  }

  grunt.config(['drush', 'install'], {
    args: args.concat(['site-install', '-yv', profile, dbUrl]),
    options: _.extend({
    }, cmd)
  });
  grunt.config(['drush', 'sql-drop'], {
    args: args.concat(['sql-drop', '-y']),
    options: _.extend({
    }, cmd)
  });
  grunt.config(['drush', 'updb'], {
    args: args.concat(['updatedb', '-y']),
    options: _.extend({
    }, cmd)
  });
  grunt.config(['shell', 'loaddb'], {
    command: 'gzip -dc <%= config.project.db %> | <%= config.project.dbConnection %>'
  });

  grunt.registerTask('install', 'Install Drupal with the configured profile, or from a database dump file if one exists.', function() {
    var done = this.async();
    var name = this.name;

    // Check for a database file first.
    var dbPath = grunt.config('config.project.db');
    if (!grunt.option('no-db-load') && dbPath && grunt.file.exists(dbPath)) {
      Drupal.loadDatabaseConnection(function(error) {
        if (error) {
          grunt.fail.fatal(error);
          done();
        }

        var tasks = [
          // Drop current database.
          'drush:sql-drop',
          // Load new database.
          'shell:loaddb',
          // Run any pending database updates.
          'drush:updb'
        ];

        tasks = require('../lib/scripts')(grunt)
          .eventify(grunt.config('config.scripts'), name, 'ops', tasks);

        grunt.task.run(tasks);
        done();
      });
    } else {
      var tasks = [
        // Run site install.
        'drush:install'
      ];

      tasks = require('../lib/scripts')(grunt)
        .eventify(grunt.config('config.scripts'), name, 'ops', tasks);

      grunt.task.run(tasks);
      done();
    }
  });

  Help.add([
    {
      task: 'install',
      group: 'Operations'
    }
  ]);
};
