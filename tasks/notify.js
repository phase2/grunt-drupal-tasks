module.exports = function(grunt) {

  /**
   * Define "notify" tasks.
   */
  if (grunt.option('notify')) {
    grunt.loadNpmTasks('grunt-notify');
    var guessProjectName = require('grunt-notify/lib/util/guessProjectName');

    grunt.config('notify_hooks', {
      options: {
        enabled: true,
        max_jshint_notifications: 5,
        title: guessProjectName(),
        success: true,
        duration: 5
      }
    });

    // This is required if you use any options.
    grunt.task.run('notify_hooks');
  }
};
