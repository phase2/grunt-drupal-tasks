module.exports = function(grunt) {

  /**
   * Define "validate" tasks, and include required plugins.
   *
   * grunt validate
   *   Evaluate the quality of all custom code.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phplint/tasks');
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phpcs/tasks');

  grunt.config('phplint', {
    all: ['src/**/*.php', 'src/**/*.module', 'src/**/*.inc', 'src/**/*.install', 'src/**/*.profile', '!src/**/*.features.*inc'],
  });

  grunt.config('phpcs', {
    drupal: {
      dir: [
        'src/**/*.php', 'src/**/*.module', 'src/**/*.inc', 'src/**/*.install', 'src/**/*.profile', 'src/**/*.css',
        '!src/**/*.features.*inc', '!src/sites/**'
      ],
    },
    options: {
      bin: '<%= config.phpcs.path %>',
      standard: '<%= config.phpcs.standard %>',
      extensions: 'php,install,module,inc,profile',
      ignoreExitCode: true,
      report: 'checkstyle',
      reportFile: '<%= config.buildPaths.reports %>/phpcs.xml'
    }
  });

  grunt.registerTask('validate', ['phplint:all', 'phpcs:drupal']);
};
