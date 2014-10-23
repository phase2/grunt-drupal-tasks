module.exports = function(grunt) {

  /**
   * Define "watch" tasks.
   *
   * Add a watch task that automatically runs the test suite when a file in
   * the Drupal docroot changes (except for files in sites/.../files) or when
   * a file in the testing features directory changes.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-contrib-watch/tasks');
  grunt.config(['watch', 'behat'], {
    files: [
      '<%= config.docroot %>/**/*',
      '!<%= config.docroot %>/sites/*/files/**/*',
      'features/**/*'
    ],
    tasks: ['behat']
  });
  grunt.config(['watch', 'validate'], {
    files: [
      '<%= config.srcPaths.drupal %>/**/*',
      '!<%= config.srcPaths.drupal %>/**/*.features.*inc',
      '!<%= config.srcPaths.drupal %>/sites/**'
    ],
    tasks: ['validate']
  });

  grunt.config('help.watch', {
    group: 'Real-time Tooling'
  });
}
