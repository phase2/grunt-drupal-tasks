var _ = require('lodash');

module.exports = function(grunt) {
  // Initialize global configuration variables.
  var config = grunt.file.readJSON('Gruntconfig.json');
  grunt.initConfig({
    config: config
  });

  // Set implicit global configuration.
  var buildPaths = grunt.config('config.buildPaths');
  buildPaths = _.extend({
    build: 'build',
    html: 'build/html',
    package: 'build/packages',
    reports: 'build/reports',
    temp: 'build/temp'
  });
  grunt.config('config.buildPaths', buildPaths);

  // Wrap Grunt's loadNpmTasks() function to change the current directory to
  // grunt-drupal-tasks, so that module dependencies of it are found.
  grunt._loadNpmTasks = grunt.loadNpmTasks;
  grunt.loadNpmTasks = function (mod) {
    var pathOrig = process.cwd();
    process.chdir(__dirname);
    grunt._loadNpmTasks(mod);
    process.chdir(pathOrig);
  };

  // Load all tasks from grunt-drupal-tasks.
  grunt.loadTasks(__dirname + '/tasks');

  // Define the default task to fully build and configure the project.
  var tasksDefault = [
    'validate',
    'newer:composerinstall',
    'symlink:profiles',
    'symlink:modules',
    'symlink:themes',
    'copy:defaults',
    'clean:sites',
    'symlink:sites',
    'mkdir:files',
    'copy:static'
  ];
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
};
