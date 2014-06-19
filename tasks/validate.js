module.exports = function(grunt) {

  /**
   * Define "validate" tasks, and include required plugins.
   *
   * grunt validate
   *   Evaluate the quality of all custom code.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phplint/tasks');
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phpcs/tasks');
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phpmd/tasks');

  grunt.config('phplint', {
    all: [
      '<%= config.srcPaths.drupal %>/**/*.php',
      '<%= config.srcPaths.drupal %>/**/*.module',
      '<%= config.srcPaths.drupal %>/**/*.inc',
      '<%= config.srcPaths.drupal %>/**/*.install',
      '<%= config.srcPaths.drupal %>/**/*.profile',
      '!<%= config.srcPaths.drupal %>/**/*.features.*inc'
    ],
  });

  grunt.config('phpcs', {
    drupal: {
      dir: [
        '<%= config.srcPaths.drupal %>/**/*.php',
        '<%= config.srcPaths.drupal %>/**/*.module',
        '<%= config.srcPaths.drupal %>/**/*.inc',
        '<%= config.srcPaths.drupal %>/**/*.install',
        '<%= config.srcPaths.drupal %>/**/*.profile',
        '<%= config.srcPaths.drupal %>/**/*.css',
        '!<%= config.srcPaths.drupal %>/**/*.features.*inc',
        '!<%= config.srcPaths.drupal %>/sites/**'
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

  grunt.config('phpmd', {
    custom: {
      dir: '<%= config.srcPaths.drupal %>/'
    },
    options: {
      bin: '<%= config.phpmd.path %>',
      rulesets: "codesize,unusedcode,naming,controversial,design",
      suffixes: "php,module,inc,install,profile",
      exclude: "<%= config.srcPaths.drupal %>/sites",
      reportFormat: 'xml',
      reportFile: '<%= config.buildPaths.build %>/reports/phpmd.xml'
    }
  });

  grunt.registerTask('validate', ['phplint:all', 'phpcs:drupal', 'phpmd:custom']);
};
