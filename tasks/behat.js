module.exports = function(grunt) {

  /**
   * Define "behat" tasks.
   *
   * Dynamically adds Behat testing tasks based on configuration sets in the
   * Gruntconfig.json file.
   *
   * Example:
   *   "siteUrls": {
   *     "default": "http://project.local",
   *     "subsite": "http://sub.project.local"
   *   }
   */
  grunt.loadNpmTasks('grunt-parallel-behat');

  var config = grunt.config.get('config'),
    flags = '';
  if (grunt.option('behat_flags')) {
    flags = grunt.option('behat_flags');
  }
  else if (config.behat && config.behat.flags) {
    flags = config.behat.flags;
  }

  if (config.buildPaths.html && config.siteUrls) {
    for (var key in config.siteUrls) {
      if (config.siteUrls.hasOwnProperty(key)) {
        grunt.config(['behat', 'site-' + key], {
          src: './features/*.feature',
          config: './behat.yml',
          maxProcesses: 5,
          bin: './bin/behat',
          flags: flags,
          debug: true,
          env: {
            "BEHAT_PARAMS": "extensions[Drupal\\DrupalExtension\\Extension][drupal][drupal_root]=" + config.buildPaths.html,
            "MINK_EXTENSION_PARAMS": "base_url=" + config.siteUrls[key]
          }
        });
      }
    }

    grunt.config('help.behat', {
      group: 'Testing & Code Quality',
      description: 'Run the Behat tests included with this project.'
    });
  }
};
