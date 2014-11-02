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

  // Load all tasks from grunt-drupal-tasks. Ensure the tasks are loaded from
  // the grunt-drupal-tasks directory, so plugin dependencies are found.
  var pathOrig = process.cwd();
  process.chdir(__dirname);
  grunt.loadTasks('./tasks');
  process.chdir(pathOrig);

  // Define the default task to fully build and configure the project.
  var tasksDefault = [
    'validate',
    'newer:drushmake:default',
    'symlink:profiles',
    'symlink:modules',
    'symlink:themes',
    'clean:sites',
    'symlink:sites',
    'mkdir:files',
    'copy:static'
  ];
  if (grunt.config.get(['composer', 'install'])) {
    tasksDefault.unshift('composer:install');
  }
  if (grunt.task.exists('compile-theme')) {
    tasksDefault.push('compile-theme');
  }
  if (grunt.config.get('behat')) {
   // tasksDefault.push('behat');
  }
  if (grunt.task.exists('bundleInstall')) {
    tasksDefault.unshift('bundleInstall');
  }

  grunt.registerTask('default', tasksDefault);

};
