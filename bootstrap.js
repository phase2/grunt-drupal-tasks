module.exports = function(grunt) {
  // Initialize global configuration variables.
  var config = grunt.file.readJSON('Gruntconfig.json');
  if (grunt.config.getRaw() === undefined) {
    grunt.initConfig({
      config: config
    });
  } else {
    grunt.config.set('config', config);
  }

  var GDT = require('./lib/init')(grunt);
  GDT.init();

  // Wrap Grunt's loadNpmTasks() function to allow loading Grunt task modules
  // that are dependencies of Grunt Drupal Tasks.
  grunt._loadNpmTasks = grunt.loadNpmTasks;
  grunt.loadNpmTasks = function(mod) {
    var internalMod = grunt.file.exists(__dirname, 'node_modules', mod);
    var pathOrig;
    if (internalMod) {
      pathOrig = process.cwd();
      process.chdir(__dirname);
    }
    grunt._loadNpmTasks(mod);
    if (internalMod) {
      process.chdir(pathOrig);
    }
  };

  // Load all tasks from grunt-drupal-tasks.
  var path = require('path');
  grunt.loadTasks(path.join(__dirname, '/tasks'));

  // Define the default task to fully build and configure the project.
  var tasksDefault = [];

  // If the "--no-validate" option is given, skip adding "validate" to default
  // tasks array.
  if (!grunt.option('no-validate')) {
    tasksDefault.push('validate');
  }

  // Process .make files if configured.
  if (grunt.config.get('config.srcPaths.make')) {
    // If build/html exists, but is empty, skip the newer check.
    // This facilitates situations where the build/html is generated as a mounted
    // directory point with a newer timestamp than the Drush Makefiles.
    //
    // We do not use the grunt-newer .cache with drushmake so skipping newer for
    // any one run does not impact later behavior.
    if (grunt.file.exists(grunt.config.get('config.buildPaths.html') + '/index.php')) {
      tasksDefault.push('newer:drushmake:default');
    } else {
      tasksDefault.push('drushmake:default');
    }
  }

  // Wire up the generated docroot to our custom code.
  tasksDefault.push('scaffold');

  if (grunt.file.exists('./composer.lock') && grunt.config.get(['composer', 'install'])) {
    if (grunt.task.exists('composer:drupal-scaffold')) {
      // Manually run `composer drupal-scaffold` since this is only automatically run on update.
      tasksDefault.unshift('composer:drupal-scaffold');
    }
    // Run `composer install` if there is already a lock file. Updates should be explicit once this file exists.
    tasksDefault.unshift('composer:install');
  } else if (grunt.config.get(['composer', 'update'])) {
    // Run `composer update` if no lock file exists. This forces `composer drupal-scaffold` to run.
    tasksDefault.unshift('composer:update');
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
