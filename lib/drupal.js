var path = require('path');

module.exports = function(grunt) {
  var module = {};

  // loadDrushStatus must be run before functions that require Drush status
  // information, such as majorVersion().
  module.loadDrushStatus = function (callback) {
    // Only let this run once per grunt execution.
    if (grunt.config('drupal')) {
      return callback(null, grunt.config('drupal'));
    }

    // Using direct spawn functionality to capture stdout.
    grunt.util.spawn({cmd: module.drushPath(), args: ['-r', grunt.config('config.buildPaths.html'), 'status', '--format=json']}, function(error, result, code) {
      var json = null;
      if (error) {
        grunt.log.writeln('drush status failed with code ' + code);
      }
      else {
        try {
          json = JSON.parse(result);
        }
        catch (e) {
          grunt.log.writeln('drush status did not produce valid JSON.');
        }
      }
      grunt.config('drupal', json);
      grunt.log.writeln('Detected Drupal ' + module.majorVersion() + ' codebase.');
      callback(error, json);
    });
  };

  module.majorVersion = function() {
    var version = process.env.GDT_DRUPAL_CORE || grunt.config('drupal.drupal-version') || '',
      versionParts = version ? version.match(/^\d+/) : '';
    return versionParts.length ? parseInt(versionParts[0]) : 0;
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
    switch (module.majorVersion()) {
      case 8:
        return path.join(grunt.config('config.buildPaths.html'), type);
      case 7:
      default:
        return path.join(grunt.config('config.buildPaths.html'), 'sites/all', type);
    }
  };

  module.drushPath = function() {
    return grunt.config('config.drush.cmd') ? path.resolve(grunt.config('config.drush.cmd')) : 'drush';
  };

  module.loadDatabaseConnection = function(callback) {
    // Only let this run once per grunt execution.
    if (grunt.config('config.project.dbConnection')) {
      return callback(null, grunt.config('config.project.dbConnection'));
    }
    grunt.util.spawn({cmd: module.drushPath(), args: ['-r', grunt.config('config.buildPaths.html'), 'sql-connect']}, function(error, result, code) {
      if (error) {
        grunt.log.writeln('drush sql-connect failed with error ' + error);
      }
      else {
        grunt.config('config.project.dbConnection', result);
      }
      callback(error, result);
    });
  }

  return module;

};
