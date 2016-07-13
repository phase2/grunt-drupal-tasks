module.exports = function(grunt) {
  /**
   * Define "watch" tasks.
   *
   * Add a watch task that automatically runs the test suite when a file in
   * the Drupal docroot changes (except for files in sites/.../files) or when
   * a file in the testing features directory changes.
   */
  grunt.loadNpmTasks('grunt-contrib-watch');
  var Help = require('../lib/help')(grunt);

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
    tasks: ['validate:newer']
  });

  grunt.config(['concurrent', 'watch-test'], {
    tasks: ['watch:validate', 'watch:test'],
    options: {
      logConcurrentOutput: true
    }
  });

  grunt.registerTask('watch-test', 'Backend operations watch task.',
    function() {
      grunt.loadNpmTasks('grunt-concurrent');
      grunt.task.run('concurrent:watch-test');
    });

  Help.add({
    task: 'watch-test',
    group: 'Real-time Tooling',
    description: 'Watch for changes that should trigger new testing and validation of the codebase.'
  });
};
