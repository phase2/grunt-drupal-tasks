module.exports = function(grunt) {

  /**
   * Define "copy" tasks.
   *
   * grunt copy:static
   *   Copies all files from src/static to the build/html directory.
   */
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.config('copy.static', {
    files: [
      {
        expand: true,
        cwd: '<%= config.srcPaths.drupal %>/static',
        src: ['**', '.**'],
        dest: '<%= config.buildPaths.html %>',
        dot: true
      }
    ]
  });
  grunt.config('copy.tempbuild', {
    files: [
      {
        expand: true,
        cwd: '<%= config.buildPaths.temp %>',
        src: ['**', '.**'],
        dest: '<%= config.buildPaths.html %>',
        dot: true
      }
    ]
  });
  grunt.config('copy.defaults', {
    files: [
      {
        expand: true,
        cwd: '<%= config.buildPaths.html %>/sites/default',
        src: ['default*'],
        dest: '<%= config.srcPaths.drupal %>/sites/default'
      }
    ]
  });
};
