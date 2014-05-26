module.exports = function(grunt) {

  /**
   * Define "drush" tasks.
   *
   * grunt drush:make
   *   Builds the Drush make file to the build/html directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-drush/tasks');
  grunt.config('drush', {
    make: {
      args: ['make', '<%= config.srcPaths.make %>'],
      src: '<%= config.srcPaths.make %>',
      dest: '<%= config.buildPaths.html %>'
    }
  });

};
