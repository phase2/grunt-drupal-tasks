module.exports = function(grunt) {

  /**
   * Define "copy" tasks.
   *
   * grunt copy:static
   *   Copies all files from src/static to the build/html directory.
   */
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.config('copy', {
    static: {
      files: [
        {
          expand: true,
          cwd: '<%= config.srcPaths.drupal %>/static',
          src: ['**', '.**'],
          dest: '<%= config.buildPaths.html %>'
        }
      ]
    },
    tempbuild: {
      files: [
        {
          expand: true,
          cwd: '<%= config.buildPaths.temp %>',
          src: ['**', '.**'],
          dest: '<%= config.buildPaths.html %>'
        }
      ]
    }
  });

  grunt.config('help.copy', {
    group: 'Utilities',
    description: "Copy the contents of the static files directory to the Drupal docroot."
  });
};
