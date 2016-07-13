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
  var Drupal = require('../lib/drupal')(grunt);
  var gdt = require('../lib/util');

  var _ = require('lodash');

  // If no path is configured for Drush, fallback to the system path.
  var cmd = {cmd: Drupal.drushPath()};

  // Allow extra arguments for drush to be supplied.
  var makeArgs = [
    'make',
    '<%= config.srcPaths.make %>',
    '<%= config.buildPaths.temp %>'
  ];
  var extraArgs = grunt.config.get('config.drush.make.args');

  if (extraArgs && extraArgs.length) {
    extraArgs.unshift(makeArgs[0]);
    extraArgs.push(makeArgs[1]);
    extraArgs.push(makeArgs[2]);
    makeArgs = extraArgs;
  }

  var limit = grunt.option('concurrency') || require('../lib/util').concurrency;
  makeArgs.push('--concurrency=' + limit);
  grunt.verbose.writeln('Configured for concurrency=' + limit);

  grunt.config(['drush', 'make'], {
    args: makeArgs,
    options: _.extend({}, cmd)
  });

  grunt.registerTask('drushmake', 'Prepare the build directory and run "drush make"', function() {
    grunt.task.run(this.options().tasks);
  });

  // The "drushmake" task will run make only if the src file specified here is
  // newer than the dest file specified. This includes scanning recursively into
  // the source directory for common places included makefiles might be located.
  grunt.config('drushmake', {
    default: {
      src: [
        // Check the configured makefile.
        '<%= config.srcPaths.make %>',
        // Check files at the immediate root of the Drupal source files.
        '<%= config.srcPaths.drupal %>/*.{make,make.yml}',
        // Recursively check inside modules, profiles, and libraries.
        '<%= config.srcPaths.drupal %>/{modules,profiles,libraries}/**/*.{make,make.yml}',
        // Check at the immediate root of each theme.
        '<%= config.srcPaths.drupal %>/themes/*/*.{make,make.yml}'
      ],
      dest: '<%= config.buildPaths.html %>'
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
