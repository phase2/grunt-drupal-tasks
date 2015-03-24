var path = require('path');

module.exports = function(grunt) {
  var module = {};

  // Triggered here to run the task once per grunt execution only when needed.
  grunt.task.run('drush-load-status');

  module.majorVersion = function() {
    return Math.floor(grunt.config('drupal.version'));
  };

  module.modulePath = function() {
    return module.drupalPath('modules');
  };

  module.themePath = function() {
    return module.drupalPath('themes');
  };

  module.libraryPath = function() {
    return module.drupalPath('libraries');
  };

  module.profilePath = function() {
    return path.join(grunt.config('config.buildPaths.html'), 'profiles');
  };

  module.sitePath = function() {
    return path.join(grunt.config('config.buildPaths.html'), 'sites');
  };

  module.drupalPath = function(type) {
    switch (module.majorVersion) {
      case 8:
        return path.join(grunt.config('config.buildPaths.html'), type);
      case 7:
      default:
        return path.join(grunt.config('config.buildPaths.html'), 'sites/all', type);
    }
  };

  return module;

};