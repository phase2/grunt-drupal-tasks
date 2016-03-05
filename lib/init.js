var _ = require('lodash');

module.exports = function(grunt) {
  var module = {};

  // Allow projects to insert config into the gdt namespace before loading GDT bootstrap.
  // This will take precedence over environment or project-shipped config.
  module.magic = function (name, envName) {
    envName = envName || name;

    return grunt.config(['gdt'].concat(name))
      || process.env['GDT_' + envName.toUpperCase()]
      || grunt.config(['config'].concat(name));
  }

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

  module.themes = function(themes) {
    // If the theme path is not set give it a sane default.
    for (var key in themes) {
      if (!themes[key].path) {
        grunt.config(['themes', key, 'path'], "<%= config.srcPaths.drupal %>/themes/" + key);
      }
    }
  }

  module.init = function() {
    if (grunt.config('config.siteUrls') === undefined)
      grunt.config('config.siteUrls', {});

    grunt.config('config.domain', module.magic('domain') || require('os').hostname());
    grunt.config('config.alias', module.magic('alias', 'SITE_ALIAS') || '@' + grunt.config('config.domain'));
    grunt.config('config.project.profile', module.magic(['project', 'profile'], 'INSTALL_PROFILE') || 'standard');
    grunt.config('config.siteUrls', module.magic('siteUrls') || {default: module.siteUrls});
    grunt.config('config.siteUrls.default', module.siteUrls());
    grunt.config('config.buildPaths', module.buildPaths());

    module.buildPaths(grunt.config('config.themes'))
  };

  return module;
};
