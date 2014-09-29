module.exports = function(grunt) {

  /**
   * Define "drush" tasks.
   *
   * grunt drush:make
   *   Builds the Drush make file to the build/html directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-drush/tasks');
  grunt.loadTasks(__dirname + '/../node_modules/grunt-newer/tasks');

  // Allow extra arguments for drush to be supplied.
  var args = ['make', '<%= config.srcPaths.make %>'],
    extra_args = grunt.config.get('config.drush.make.args');
  if (extra_args && extra_args.length) {
    extra_args.unshift(args[0]);
    extra_args.push(args[1]);
    args = extra_args;
  }

  grunt.config('drush', {
    make: {
      args: args,
      dest: '<%= config.buildPaths.html %>'
    }
  });

  grunt.registerTask('drushmake', 'Run "drush make" if the makefile is newer than the dest directory.', function() {
    grunt.task.run('clean:default', 'mkdir:init', 'drush:make');
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
};
