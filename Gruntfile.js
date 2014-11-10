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

  // Load environment-based values.
  var baseUrl = process.env.DRUPAL_GRUNT_BASEURL || config.get('config.siteUrls.baseUrl');
  var paths = config.get('config.siteUrls.paths');
  if (baseUrl && paths) {
    var completePaths = paths.map(function(value, index, arr) {
      return baseUrl . value;
    });
  }
  config.set('config.siteUrls.paths', completePaths);

  // Set the siteUrls.default URL for backwards compatibility.
  var defaultUrl = config.get('config.siteUrls.default') || baseUrl;
  config.set('config.siteUrls.default', defaultUrl);

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
  if (grunt.task.exists('bundleInstall')) {
    tasksDefault.unshift('bundleInstall');
  }
  if (grunt.task.exists('compile-theme')) {
    tasksDefault.push('compile-theme');
  }

  grunt.registerTask('default', tasksDefault);
};
