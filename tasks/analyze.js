module.exports = function(grunt) {

  /**
   * Define "analyze" tasks, and include required plugins.
   *
   * grunt analyze
   *   Deep analysis on custom code. May be a long-running task.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phpmd/tasks');

  grunt.config('phpmd', {
    custom: {
      dir: '<%= config.srcPaths.drupal %>/'
    },
    options: {
      bin: '<%= config.phpmd.path %>',
      rulesets: "node_modules/drupal-grunt-starter/phpmd.xml",
      suffixes: "php,module,inc,install,profile",
      exclude: "<%= config.srcPaths.drupal %>/sites",
      reportFormat: 'xml',
      reportFile: '<%= config.buildPaths.reports %>/phpmd.xml'
    }
  });

  grunt.registerTask('analyze', ['phpmd:custom']);
};
