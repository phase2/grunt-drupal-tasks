module.exports = function(grunt) {

  /**
   * Define "drush" tasks.
   */
  grunt.loadNpmTasks('grunt-drush');
  var Help = require('../lib/help')(grunt);

  var path = require('path'),
    _ = require('lodash');

  // If no path is configured for Drush, fallback to the system path.
  var cmd = grunt.config('config.drush.cmd') !== undefined ? {cmd: path.resolve(grunt.config('config.drush.cmd'))} : {};

  grunt.config('drush', {
    liteinstall: {
      args: ['site-install', '-y', 'standard', '--db-url=sqlite://drupal:drupal@drupal.sqlite'],
      options: _.extend({
        cwd: '<%= config.buildPaths.html %>'
      }, cmd)
    },
    runserver: {
      args: ['runserver', '8080'],
      options: _.extend({
        cwd: '<%= config.buildPaths.html %>'
      }, cmd)
    }
  });
};
