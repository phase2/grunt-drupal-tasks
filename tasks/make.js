module.exports = function(grunt) {

  /**
   * Define "drush" tasks.
   *
   * grunt drush:make
   *   Builds the Drush make file to the build/html directory.
   */
  grunt.loadNpmTasks('grunt-drush');
  grunt.loadNpmTasks('grunt-newer');

  var Help = require('../lib/help')(grunt),
    Drupal = require('../lib/drupal')(grunt),
    gdt = require('../lib/util');

  var path = require('path'),
    _ = require('lodash');

  // If no path is configured for Drush, fallback to the system path.
  var cmd = {cmd: Drupal.drushPath()};

  // Allow extra arguments for drush to be supplied.
  var make_args = ['make', '<%= config.srcPaths.make %>', '<%= config.buildPaths.temp %>'];
  var extra_args = grunt.config.get('config.drush.make.args');

  if (extra_args && extra_args.length) {
    extra_args.unshift(make_args[0]);
    extra_args.push(make_args[1]);
    extra_args.push(make_args[2]);
    make_args = extra_args;
  }

  var limit = grunt.option('concurrency') || require('../lib/util').concurrency;
  make_args.push('--concurrency=' + limit);
  grunt.verbose.writeln('Configured for concurrency=' + limit);

  grunt.config(['drush', 'make'], {
    args: make_args,
    options: _.extend({}, cmd)
  });

  grunt.registerTask('drushmake', 'Prepare the build directory and run "drush make"', function() {
    grunt.task.run(this.options().tasks);
  });

  // The "drushmake" task will run make only if the src file specified here is
  // newer than the dest file specified. This includes all make files in the
  // source directory to catch make files included from the primary one.
  grunt.config('drushmake', {
    default: {
      src: [
        '<%= config.srcPaths.make %>',
        '<%= config.srcPaths.drupal %>/*.make',
        '<%= config.srcPaths.drupal %>/*.make.yml'
      ],
      dest: '<%= config.buildPaths.html %>',
    },
    options: {
      tasks: [
        'mkdir:init',
        'clean:temp',
        'drush:make',
        'clean:default',
        gdt.canRsync() ? 'rsync:tempbuild' : 'copy:tempbuild',
        'clean:temp'
      ]
    }
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
