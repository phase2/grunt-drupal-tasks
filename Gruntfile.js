module.exports = function(grunt) {
  if (grunt.option('timer')) {
    // shows how long grunt tasks take ~ https://github.com/sindresorhus/time-grunt
    require('time-grunt')(grunt);
  }

  // Initialize global configuration variables.
  var config = grunt.file.readJSON('Gruntconfig.json');
  grunt.initConfig({
    config: config
  });

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
    'newer:drushmake:default',
    'symlink:profiles',
    'symlink:modules',
    'symlink:themes',
    'copy:defaults',
    'clean:sites',
    'symlink:sites',
    'mkdir:files',
    'copy:static'
  ];
  if (grunt.config.get(['composer', 'install'])) {
    tasksDefault.unshift('composer:install');
  }
  if (grunt.task.exists('bundleInstall')) {
    tasksDefault.unshift('bundleInstall');
  }
  if (grunt.task.exists('compile-theme')) {
    tasksDefault.push('compile-theme');
  }

  grunt.registerTask('default', tasksDefault);
};
