var _ = require('lodash');

module.exports = function(grunt) {
  var module = {};

  module.domain = function() {
    return process.env.GDT_DOMAIN || grunt.config('config.domain') || require('os').hostname();
  };

  // Ensure a default URL for the project.
  module.siteUrls = function() {
    return grunt.config('config.siteUrls.default') || "http://<%= config.domain %>";
  }

  module.buildPaths = function() {
    // Set implicit global configuration.
    var buildPaths = grunt.config('config.buildPaths');
    buildPaths = _.extend({
      build: 'build',
      html: 'build/html',
      package: 'build/packages',
      reports: 'build/reports',
      temp: 'build/temp'
    }, buildPaths);

    return buildPaths;
  }

  module.init = function() {
    if (grunt.config('config.siteUrls') === undefined)
      grunt.config('config.siteUrls', {});

    grunt.config('config.domain', module.domain());
    grunt.config('config.siteUrls.default', module.siteUrls());
    grunt.config('config.buildPaths', module.buildPaths());
  };

  return module;
};
