module.exports = function(grunt) {

  /**
   * Define "notify" tasks.
   */
  if (grunt.option('quiet') || (process.env.GRUNT_DRUPAL_QUIET && ! grunt.option('notify')) {
    return;
  }

  grunt.loadNpmTasks('grunt-notify');
  var guessProjectName = require('grunt-notify/lib/util/guessProjectName');

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
      threshold: grunt.config.get('config.notify.threshold') || 10,
      duration: 5,
      // Supposed to suppress notify_hooks log header, but not working.
      gruntLogHeader: false
    }
  });

  // This is required if you use any options.
  grunt.task.run('notify_hooks');

};
