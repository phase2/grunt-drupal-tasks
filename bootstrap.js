module.exports = function(grunt) {
  // Initialize global configuration variables.
  var config = grunt.file.readJSON('Gruntconfig.json');
  grunt.initConfig({
    config: config
  });

  // Set up default global configuration.
  var GDT = require('./lib/init')(grunt);
  GDT.init();

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
  var tasksDefault = [];
  
  if (grunt.config.get(['composer', 'install'])) {
    tasksDefault.push('composer:install');
  }
  if (grunt.task.exists('bundle-install')) {
    tasksDefault.push('bundle-install');
  }
  // If the "--no-validate" option is given, skip adding "validate" to task array.
  if (!grunt.option('no-validate')) {
    tasksDefault.push('validate');
  }
  tasksDefault.push('newer:drushmake:default');
  tasksDefault.push('scaffold');
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
