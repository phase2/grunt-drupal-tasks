module.exports = function(grunt) {

  /**
   * Define "behat" tasks.
   *
   * Dynamically adds Behat testing tasks based on configuration sets in the
   * package.json file.
   *
   * Example:
   *   "config": {
   *     "docroot": "/var/www/vhosts/dev-site.local",
   *     "site_urls": {
   *       default: http://dev-site.local"
   *     }
   *   }
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-parallel-behat/tasks');
  var config = grunt.config.get('config');
  if (config.buildPaths.html && config.siteUrls) {
    for (var key in config.siteUrls) {
      if (config.siteUrls.hasOwnProperty(key)) {
        grunt.config(['behat', 'site-' + key], {
          src: './features/*.feature',
          config: './behat.yml',
          maxProcesses: 5,
          bin: './bin/behat',
          flags: '',
          env: {
            //"BEHAT_PARAMS": "extensions[Drupal\\DrupalExtension\\Extension][drupal][drupal_root]=./" + config.buildPaths.html,
            //"MINK_EXTENSION_PARAMS": "base_url=" + config.siteUrls[key]
          }
        });
      }
    }
  }

}
