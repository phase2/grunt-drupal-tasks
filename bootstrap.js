var _ = require('lodash');

module.exports = function(grunt) {
  // Initialize global configuration variables.
  var config = grunt.file.readJSON('Gruntconfig.json');
  grunt.initConfig({
    config: config
  });

  // Load environment-based values.
  var domain = process.env.GRUNT_DRUPAL_DOMAIN || grunt.config('config.domain') || require('os').hostname();
  grunt.config('config.domain', domain);

  // Set implicit global configuration.
  var buildPaths = grunt.config('config.buildPaths');
  buildPaths = _.extend({
    build: 'build',
    html: 'build/html',
    package: 'build/packages',
    reports: 'build/reports',
    temp: 'build/temp'
  }, buildPaths);
  grunt.config('config.buildPaths', buildPaths);

  // Wrap Grunt's loadNpmTasks() function to allow loading Grunt task modules
  // that are dependencies of Grunt Drupal Tasks.
  grunt._loadNpmTasks = grunt.loadNpmTasks;
  grunt.loadNpmTasks = function (mod) {
    var internalMod = grunt.file.exists(__dirname, 'node_modules', mod);
    if (internalMod) {
      var pathOrig = process.cwd();
      process.chdir(__dirname);
    }
    grunt._loadNpmTasks(mod);
    if (internalMod) {
      process.chdir(pathOrig);
    }
  };

  // Load all tasks from grunt-drupal-tasks.
  grunt.loadTasks(__dirname + '/tasks');

  // Define the default task to fully build and configure the project.
  var tasksDefault = [
    'validate',
    'newer:drushmake:default',
    'scaffold'
  ];
  if (grunt.config.get(['composer', 'install'])) {
    tasksDefault.unshift('composer:install');
  }
  if (grunt.task.exists('bundle-install')) {
    tasksDefault.unshift('bundle-install');
  }
  if (grunt.task.exists('compile-theme')) {
    tasksDefault.push('compile-theme');
  }
  grunt.registerTask('default', tasksDefault);

  // If the "--timer" option is given, enable time-grunt to show how long each
  // task takes.
  if (grunt.option('timer')) {
    require('time-grunt')(grunt);
  }

  require('grunt-log-headers')(grunt);
};
