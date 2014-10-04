module.exports = function(grunt) {

  /**
   * Define "validate" and "analyze" tasks, and include required plugins.
   *
   * These tasks are used to ensure code quality.
   *
   * grunt validate
   *   Evaluate the quality of all custom code to make sure it is safe to push.
   *   Should be reasonably fast and display on the command-line.
   *
   * grunt analyze
   *   Deeper inspection & analyze of codebase, not done on every build.
   *   Produces reports for Jenkins. May be a long-running task.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phplint/tasks');
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phpcs/tasks');
  grunt.loadTasks(__dirname + '/../node_modules/grunt-phpmd/tasks');

  // Task set aliases are registered at the end of the file based on these values.
  var validate = [];
  var analyze = [];

  grunt.config('phplint', {
    all: [
      '<%= config.srcPaths.drupal %>/**/*.php',
      '<%= config.srcPaths.drupal %>/**/*.module',
      '<%= config.srcPaths.drupal %>/**/*.inc',
      '<%= config.srcPaths.drupal %>/**/*.install',
      '<%= config.srcPaths.drupal %>/**/*.profile',
      '!<%= config.srcPaths.drupal %>/**/*.features.*inc',
      '!<%= config.srcPaths.drupal %>/sites/**'
    ],
  });
  validate.push('phplint:all');

  if (grunt.config.get('config.phpcs') != undefined) {
    var phpcs = [
      '<%= config.srcPaths.drupal %>/**/*.php',
      '<%= config.srcPaths.drupal %>/**/*.module',
      '<%= config.srcPaths.drupal %>/**/*.inc',
      '<%= config.srcPaths.drupal %>/**/*.install',
      '<%= config.srcPaths.drupal %>/**/*.profile',
      '<%= config.srcPaths.drupal %>/**/*.css',
      '!<%= config.srcPaths.drupal %>/**/*.features.*inc',
      '!<%= config.srcPaths.drupal %>/sites/**'
    ];
    grunt.config('phpcs', {
      analyze: {
        dir: phpcs
      },
      drupal: {
        dir: phpcs
      },
      validate: {
        dir: phpcs,
        report: grunt.config.get('config.phpcs.validateReport') || 'summary',
        reportFile: false,
      },
      inspect: {
        dir: phpcs,
        report: 'full',
        reportFile: false
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

    validate.push('phpcs:validate');
    analyze.push('phpcs:analyze');
  }

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
    analyze.push('phpmd:custom');
  }

  grunt.registerTask('validate', validate);
  grunt.registerTask('analyze', analyze);
};
