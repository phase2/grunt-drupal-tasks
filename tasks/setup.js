module.exports = function(grunt) {

  /**
   * Define tasks for automatic setup of a local project repo.
   *
   * These are tasks that cannot be initialized into the repository via Yeoman,
   * such as githooks.
   */

  grunt.registerTask('setup', 'Perform basic project setup tasks that cannot ship with the codebase.', function() {
    grunt.loadNpmTasks('grunt-githooks');
    grunt.config('githooks', {
      quality: {
        'pre-commit': 'validate:staged'
      }
    });
    grunt.task.run([
      'githooks'
    ]);
  });
};
