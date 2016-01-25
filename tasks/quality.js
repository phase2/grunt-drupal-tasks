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
  grunt.loadNpmTasks('grunt-eslint');
  grunt.loadNpmTasks('grunt-force-task');
  grunt.loadNpmTasks('grunt-phplint');
  grunt.loadNpmTasks('grunt-phpcs');
  grunt.loadNpmTasks('grunt-phpmd');

  var Help = require('../lib/help')(grunt),
    _ = require('lodash');

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
    all: grunt.config.get('config.phplint.dir') ? grunt.config.get('config.phplint.dir') : defaultPatterns
  });
  validate.push('phplint:all');

  if (grunt.config.get('config.phpcs')) {
    var phpcs = grunt.config.get('config.phpcs.dir') || [
        '<%= config.srcPaths.drupal %>/**/*.css'
      ].concat(defaultPatterns);

    var phpStandard = grunt.config('config.phpcs.standard')
      || 'vendor/drupal/coder/coder_sniffer/Drupal';

    // Support deprecated config.phpcs.ignoreExitCode value until 1.0.
    var ignoreError = grunt.config('config.validate.ignoreError') || grunt.config('config.phpcs.ignoreExitCode');
    ignoreError = ignoreError === undefined ? false : ignoreError;

    // Process phpcs.dir paths from config for template placeholders.
    var phpcsPaths = _.map(phpcs, function (item) {
      return grunt.template.process(item);
    });

    // Only enable phpcs if at least one source file is identified when the
    // configured paths are expanded.
    if (grunt.file.expand(phpcsPaths).length) {
      grunt.config('phpcs', {
        analyze: {
          src: phpcs
        },
        drupal: {
          src: phpcs
        },
        validate: {
          src: phpcs,
          options: {
            report: grunt.config.get('config.phpcs.validateReport') || 'full',
            reportFile: false
          }
        },
        full: {
          src: phpcs,
          options: {
            report: 'full',
            reportFile: false
          }
        },
        summary: {
          src: phpcs,
          options: {
            report: 'summary',
            reportFile: false
          }
        },
        gitblame: {
          src: phpcs,
          options: {
            report: 'gitblame',
            reportFile: false
          }
        },
        options: {
          bin: '<%= config.phpcs.path %>',
          standard: phpStandard,
          ignoreExitCode: ignoreError,
          report: 'checkstyle',
          reportFile: '<%= config.buildPaths.reports %>/phpcs.xml'
        }
      });
      validate.push('phpcs:validate');
      analyze.push('phpcs:analyze');
    }
  }

  if (grunt.config.get('config.phpmd')) {
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

  var themes = grunt.config('config.themes');
  if (grunt.config.get('config.eslint')) {
    var eslintConfig = grunt.config.get('config.eslint'),
      eslintTarget = eslintConfig.dir || [
          '<%= config.srcPaths.drupal %>/**/*.js',
          '!<%= config.srcPaths.drupal %>/sites/**/files/**/*.js'
        ],
      eslintTargetAnalyze = eslintTarget,
      eslintConfigFile = eslintConfig.configFile || './.eslintrc',
      eslintIgnoreError = grunt.config.get('config.validate.ignoreError') === undefined ? false : grunt.config.get('config.validate.ignoreError'),
      eslintName = eslintIgnoreError ? 'force:eslint' : 'eslint';

    for (var key in themes) {
      if (themes[key].scripts && themes[key].scripts.validate) {
        // If the theme has a validate task of it's own, then exclude its
        // javascript files from our validate process.
        eslintTarget.push('!<%= config.srcPaths.drupal %>/themes/' + key + '/**/*.js');
      }
      if (themes[key].scripts && themes[key].scripts.analyze) {
        // If the theme has an analyze task of it's own, then exclude its
        // javascript files from our analyze process.
        eslintTargetAnalyze.push('!<%= config.srcPaths.drupal %>/themes/' + key + '/**/*.js');
      }
    }

    // Process eslint.dir paths from config for template placeholders.
    var eslintPaths = _.map(eslintTarget, function (item) {
      return grunt.template.process(item);
    });

    // Only enable eslint if at least one source file is identified when the
    // configured paths are expanded.
    if (grunt.file.expand(eslintPaths).length) {
      grunt.config('eslint', {
        options: {
          configFile: eslintConfigFile
        },
        validate: eslintTarget,
        analyze: {
          options: {
            format: 'checkstyle',
            outputFile: '<%= config.buildPaths.reports %>/eslint.xml'
          },
          src: eslintTargetAnalyze
        }
      });
      validate.push(eslintName + ':validate');
      analyze.push(eslintName + ':analyze');
    }
  }

  // If any of the themes have code quality commands, attach them here.
  for (var key in themes) {
    if (themes[key].scripts && themes[key].scripts.validate) {
      validate.push('themes:' + key + ':validate');
    }
    if (themes[key].scripts && themes[key].scripts.analyze) {
      validate.push('themes:' + key + ':analyze');
    }
  }

  grunt.registerTask('validate', 'Validate the quality of custom code.', function(mode) {
    if (mode == 'newer' || mode == 'staged') {
      // This works because grunt-newer and grunt-staged have consisting naming.
      grunt.loadNpmTasks('grunt-' + mode);
      // Wrap each task configured for validate in the newer command.
      // grunt-phplint already contains complex caching that does the same thing.
      validate = validate.map(function(item) { return item != 'phplint:all' ? mode + ':' + item : item; });
    }
    grunt.task.run(validate);
  });

  if (analyze.length < 2) {
    grunt.registerTask('analyze', analyze);
  }
  else {
    grunt.loadNpmTasks('grunt-concurrent');
    grunt.config(['concurrent', 'analyze'], {
      tasks: analyze,
      options: {
        logConcurrentOutput: true
      }
    });

    grunt.registerTask('analyze', ['mkdir:init', 'concurrent:analyze']);
  }

  Help.add([
    {
      task: 'validate',
      group: 'Testing & Code Quality',
      description: 'Quick code health check for syntax errors and basic practices. (e.g. PHPCS w/ Drush Coder rules)'
    },
    {
      task: 'analyze',
      group: 'Testing & Code Quality',
      description: 'Static codebase analysis to detect problems. Outputs Jenkins-compatible reports. (e.g. PHPMD)'
    }
  ]);
};
