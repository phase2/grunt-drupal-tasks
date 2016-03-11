var _ = require('lodash');

module.exports = function(grunt) {

  /**
   * Define tasks for automatic setup of a local project git repo.
   *
   * These are tasks that cannot be initialized into the repository via Yeoman,
   * such as githooks.
   */


  if (!grunt.file.exists('build') && !grunt.file.exists('.git/hooks/pre-comit') && !grunt.config('config.validate.ignoreError')) {
    grunt.log.writeln('Run `grunt git-setup` to perform one-time repo upgrades, such as adding a pre-commit code scanner.');
  }

  grunt.registerTask('git-setup', 'Set up the project git repository with some one-time configurations.', function() {
    grunt.loadNpmTasks('grunt-githooks');

    var tasks = grunt.config('config.git.hooks') || {};
    if (tasks !== undefined) {
      tasks = [];
    }
    tasks.push('validate:staged')

    // Githooks task may be configured via Gruntconfig.
    grunt.config('githooks', {
      options: {
        command: grunt.config('config.git.hook-command') || 'grunt'
      },
      gdt: {
        'pre-commit': _.uniq(tasks).join(' ')
      }
    });

    grunt.task.run([
      'githooks'
    ]);
  });
};
