module.exports = function(grunt) {

  /**
   * Define "analyze" tasks, and include required plugins.
   *
   * grunt analyze
   *   Deep analysis on custom code. May be a long-running task.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phpmd/tasks');

  var steps = [];
  if (grunt.config.get('config.phpmd') != undefined) {
    var phpmdConfig = grunt.config.get('config.phpmd.configPath') || 'phpmd.xml';
    grunt.config('phpmd', {
      custom: {
        dir: '<%= config.srcPaths.drupal %>/'
      },
      options: {
        bin: '<%= config.phpmd.path %>',
        rulesets: phpmdConfig,
        suffixes: "php,module,inc,install,profile",
        exclude: "<%= config.srcPaths.drupal %>/sites",
        reportFormat: 'xml',
        reportFile: '<%= config.buildPaths.reports %>/phpmd.xml'
      }
    });
    steps.push('phpmd:custom');
  }

  grunt.registerTask('analyze', steps);

  grunt.config('help.analyze', {
    group: 'Testing & Code Quality'
  });
};
