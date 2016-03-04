module.exports = function(grunt) {

  /**
   * Define "copy" tasks.
   *
   * grunt copy:static
   *   Copies all files from src/static to the build/html directory.
   * grunt rsync:tempbuild
   *   Duplicate Drupal docroot from temporary location to the final build target.
   * grunt copy:tempbuild
   *   Original implementation of rsync:tempbuild, preserved for backwards
   *   compatibility and Windows support.
   * grunt copy:defaults
   *   Copies Drupal's sites/default directory into the custom codebase.
   */
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-rsync');

  grunt.config('copy.static', {
    options: {
      mode: true
    },
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
    options: {
      mode: true
    },
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

  grunt.config('rsync.tempbuild', {
    options: {
      args: [
        '-ahW',
        '--stats'
      ],
      src: '<%= config.buildPaths.temp %>/',
      dest: '<%= config.buildPaths.html %>'
    },
  });

  grunt.config('copy.defaults', {
    options: {
      mode: true
    },
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
