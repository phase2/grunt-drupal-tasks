module.exports = function(grunt) {

  /**
   * Define "drush" tasks.
   *
   * grunt drush:make
   *   Builds the Drush make file to the build/html directory.
   */
  grunt.loadNpmTasks('grunt-drush');
  grunt.loadNpmTasks('grunt-newer');
  var Help = require('../lib/help')(grunt);

  var path = require('path'),
    _ = require('lodash');

  // If no path is configured for Drush, fallback to the system path.
  var cmd = grunt.config('config.drush.cmd') !== undefined ? {cmd: path.resolve(grunt.config('config.drush.cmd'))} : {};

  // Allow extra arguments for drush to be supplied.
  var args = ['make', '<%= config.srcPaths.make %>', '<%= config.buildPaths.temp %>'],
    extra_args = grunt.config.get('config.drush.make.args');
  if (extra_args && extra_args.length) {
    extra_args.unshift(args[0]);
    extra_args.push(args[1]);
    extra_args.push(args[2]);
    args = extra_args;
  }

  grunt.config('drush', {
    make: {
      args: args,
      options: _.extend({}, cmd)
    },
    liteinstall: {
      args: ['site-install', '-y', 'standard', '--db-url=sqlite://drupal:drupal@drupal.sqlite'],
      options: _.extend({
        cwd: '<%= config.buildPaths.html %>'
      }, cmd)
    },
    runserver: {
      args: ['runserver', '8080'],
      options: _.extend({
        cwd: '<%= config.buildPaths.html %>'
      }, cmd)
    }
  });

  grunt.registerTask('drushmake', 'Prepare the build directory and run "drush make"', function() {
    grunt.task.run('mkdir:init', 'clean:temp', 'drush:make', 'clean:default', 'copy:tempbuild', 'clean:temp');
  });

  // The "drushmake" task will run make only if the src file specified here is
  // newer than the dest file specified. This includes all make files in the
  // source directory to catch make files included from the primary one.
  grunt.config('drushmake', {
    default: {
      src: ['<%= config.srcPaths.make %>', '<%= config.srcPaths.drupal %>/**/*.make'],
      dest: '<%= config.buildPaths.html %>'
    }
  });

  grunt.registerTask('drush-load-status', 'Run drush status and load result into configuration.', function() {
    // Using direct spawn functionality to capture stdout.
    grunt.util.spawn({cmd: 'drush', args: [ '-r build/html', 'status', '--format=json' ]}, function(error, result, code) {
      var json = {};
      if (error) {
        grunt.log.writeln('drush status failed');
      }
      else {
        try {
          json = JSON.parse(result);
        }
        catch (e) {
          grunt.log.writeln('drush status did not produce valid JSON.');
        }
      }
      grunt.config('drupal', json);
      grunt.log.writeln('Detected Drupal ' + json.version + ' codebase.');
    });
  });

  Help.add([
    {
      task: 'drushmake',
      group: 'Dependency Management'
    },
    {
      task: 'newer',
      group: 'Dependency Management',
      description: 'Use "newer:drushmake" to run the drushmake task only if the make file was updated.'
    }
  ]);
};
