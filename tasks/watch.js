module.exports = function(grunt) {

  /**
   * Define "watch" tasks.
   *
   * Add a watch task that automatically runs the test suite when a file in
   * the Drupal docroot changes (except for files in sites/.../files) or when
   * a file in the testing features directory changes.
   */
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-parallel');

  grunt.config(['watch', 'test'], {
    files: [
      '<%= config.srcPaths.drupal %>/**/*',
      '!<%= config.srcPaths.drupal %>/sites/*/files/**/*',
      'features/**/*'
    ],
    tasks: ['test']
  });
  grunt.config(['watch', 'validate'], {
    files: [
      '<%= config.srcPaths.drupal %>/**/*',
      '!<%= config.srcPaths.drupal %>/**/*.features.*inc',
      '!<%= config.srcPaths.drupal %>/sites/**'
    ],
    tasks: ['validate']
  });

  grunt.config(['parallel', 'watch-test'], {
    options: {
      stream: true
    },
    tasks: [
      {
        grunt: true,
        args: ['watch:validate']
      },
      {
        grunt: true,
        args: ['watch:test']
      }
    ]
  });

  grunt.registerTask('watch-test', ['parallel:watch-test']);

  grunt.config('help.watch-test', {
    group: 'Real-time Tooling',
    description: "Watch for changes that should trigger new testing and validation of the codebase."
  });
}
