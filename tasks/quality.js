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
  grunt.loadNpmTasks('grunt-phplint');
  grunt.loadNpmTasks('grunt-phpcs');
  grunt.loadNpmTasks('grunt-phpmd');
  grunt.loadNpmTasks('grunt-eslint');

  // Task set aliases are registered at the end of the file based on these values.
  var validate = [];
  var analyze = [];

  var defaultPatterns = [
    '<%= config.srcPaths.drupal %>/**/*.php',
    '<%= config.srcPaths.drupal %>/**/*.module',
    '<%= config.srcPaths.drupal %>/**/*.inc',
    '<%= config.srcPaths.drupal %>/**/*.install',
    '<%= config.srcPaths.drupal %>/**/*.profile',
    '!<%= config.srcPaths.drupal %>/sites/**',
    '!<%= config.srcPaths.drupal %>/**/*.box.inc',
    '!<%= config.srcPaths.drupal %>/**/*.features.*inc',
    '!<%= config.srcPaths.drupal %>/**/*.pages_default.inc',
    '!<%= config.srcPaths.drupal %>/**/*.panelizer.inc',
    '!<%= config.srcPaths.drupal %>/**/*.strongarm.inc'
  ];

  grunt.config('phplint', {
    all: defaultPatterns
  }); 
  validate.push('phplint:all');

  if (grunt.config.get('config.phpcs') != undefined) {
    var phpcs = grunt.config.get('config.phpcs.dir') || [
      '<%= config.srcPaths.drupal %>/**/*.css'
    ].concat(defaultPatterns);

    grunt.config('phpcs', {
      analyze: {
        dir: phpcs
      },
      drupal: {
        dir: phpcs
      },
      validate: {
        dir: phpcs,
        report: grunt.config.get('config.phpcs.validateReport') || 'full',
        reportFile: false,
      },
      full: {
        dir: phpcs,
        report: 'full',
        reportFile: false
      },
      summary: {
        dir: phpcs,
        report: 'summary',
        reportFile: false
      },
      gitblame: {
        dir: phpcs,
        report: 'gitblame',
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

  grunt.config('eslint', grunt.config.get('eslint') || {
    target: ['<%= config.srcPaths.drupal %>/**/*.js']
  });
  validate.push('eslint');

  grunt.registerTask('validate', validate);
  grunt.registerTask('analyze', analyze);

  grunt.config('help.validate', {
    group: 'Testing & Code Quality',
    description: 'Quick code health check for syntax errors and basic practices. (e.g. PHPCS w/ Drush Coder rules)'
  });
  grunt.config('help.analyze', {
    group: 'Testing & Code Quality',
    description: 'Static codebase analysis to detect problems. Outputs Jenkins-compatible reports. (e.g. PHPMD)'
  });
};
