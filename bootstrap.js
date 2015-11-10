module.exports = function(grunt) {
  // Initialize global configuration variables.
  var config = grunt.file.readJSON('Gruntconfig.json');
  if (grunt.config.getRaw() === undefined) {
    grunt.initConfig({
      config: config
    });
  }
  else {
    grunt.config.set('config', config);
  }

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
  var tasksDefault = [
    'validate'
  ];

  // If build/html exists, but is empty, skip the newer check.
  // This facilitates situations where the build/html is generated as a mounted
  // directory point with a newer timestamp than the Drush Makefiles.
  //
  // We do not use the grunt-newer .cache with drushmake so skipping newer for
  // any one run does not impact later behavior.
  if (grunt.file.exists(grunt.config.get('config.buildPaths.html') + '/index.php')) {
    tasksDefault.push('newer:drushmake:default');
  }
  else {
    tasksDefault.push('drushmake:default');
  }

  // Wire up the generated docroot to our custom code.
  tasksDefault.push('scaffold');

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
