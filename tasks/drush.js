module.exports = function(grunt) {

  /**
   * Define "drush" tasks.
   *
   * grunt drush:make
   *   Builds the Drush make file to the build/html directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-drush/tasks');
  grunt.loadTasks(__dirname + '/../node_modules/grunt-newer/tasks');

  grunt.config('drush', {
    make: {
      args: ['make', '<%= config.srcPaths.make %>'],
      dest: '<%= config.buildPaths.html %>'
    }
  });

  grunt.registerTask('drushmake', 'Run "drush make" if the makefile is newer than the dest directory.', function() {
    grunt.task.run('clean:default', 'mkdir:init', 'drush:make');
  });

  // The "drushmake" task will run make only if the src file specified here is
  // newer than the dest file specified.
  grunt.config('drushmake', {
    default: {
      src: '<%= config.srcPaths.make %>',
      dest: '<%= config.buildPaths.html %>'
    }
  });
};
