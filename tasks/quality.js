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

  var filesToProcess = function(patterns) {
    var paths = _.map(patterns, function (item) {
      return grunt.template.process(item);
    });

    // If this is evaluated to truthy at least one file matched.
    return grunt.file.expand(paths).length;
  }

  grunt.registerTask('validate', 'Validate the quality of custom code.', function(mode) {
    var phpcs = grunt.config.get('phpcs.validate');
    if (phpcs) {
      if (filesToProcess(phpcs.src)) {
        validate.push('phpcs:validate');
      }
    }
    var eslint = grunt.config.get('eslint.validate');
    if (eslint) {
      if (filesToProcess(eslint.validate)) {
        validate.push('eslint:validate');
      }
    }

    if (mode == 'newer' || mode == 'staged') {
      // This works because grunt-newer and grunt-staged have consisting naming.
      grunt.loadNpmTasks('grunt-' + mode);
      // Wrap each task configured for validate in the newer command.
      // grunt-phplint already contains complex caching that does the same thing.
      validate = validate.map(function(item) { return item != 'phplint:all' ? mode + ':' + item : item; });
    }

    if (validate.length) {
      grunt.task.run(validate);
    }
  });

  grunt.registerTask('analyze', 'Generate reports on code quality for use by Jenkins or other visualization tools.', function() {
    var phpcs = grunt.config.get('phpcs.analyze');
    if (phpcs) {
      if (filesToProcess(phpcs.src)) {
        analyze.push('phpcs:analyze');
      }
    }
    var eslint = grunt.config.get('eslint.analyze');
    if (eslint) {
      // The eslint:analyze task has a deeper configuration structure than eslint:validate.
      if (filesToProcess(eslint.src)) {
        analyze.push('eslint:analyze');
      }
    }

    if (analyze.length) {
      if (analyze.length > 1) {
        grunt.loadNpmTasks('grunt-concurrent');
        grunt.config(['concurrent', 'analyze'], {
          tasks: analyze,
          options: {
            logConcurrentOutput: true
          }
        });
        var tasks = ['concurrent:analyze']
      }
      else {
        var tasks = analyze;
      }

      tasks.unshift('mkdir:init');
      grunt.task.run(tasks);
    }
  });

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
