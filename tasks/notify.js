module.exports = function(grunt) {
  /**
   * Define "notify" tasks.
   */
  if ((grunt.option('quiet') || process.env.GDT_QUIET) && !grunt.option('notify')) {
    return;
  }

  grunt.loadNpmTasks('grunt-notify');
  var guessProjectName = require('grunt-notify/lib/util/guessProjectName');

  // Set the default threshold.
  var threshold = grunt.config('config.notify.threshold') || 10;
  // If the notify flag is used, drop the threshold to ensure notifications are
  // triggered.
  if (grunt.option('notify')) {
    threshold = 0;
  }

  grunt.config('notify_hooks', {
    options: {
      // title needs to be reset to the same as the grunt-notify default because
      // the guessing mechanism thinks that grunt-drupal-tasks is the project.
      title: guessProjectName(),
      // Only trigger success messages if the process has taken longer than the
      // configured notifyThreshold.
      success: true,
      // The 'threshold' option is currently implemented to be triggered if
      // enabled is falsy. If enabled is truthy the threshold is moot.
      enabled: grunt.option('notify'),
      threshold: threshold,
      duration: 5,
      // Supposed to suppress notify_hooks log header, but not working.
      gruntLogHeader: false
    }
  });

  // This is required if you use any options.
  grunt.task.run('notify_hooks');
};
