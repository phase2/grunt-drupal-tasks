module.exports = function(grunt) {

  /**
   * Manage performance testing and best practices tasks.
   *
   * grunt pagespeed
   *   Evaluate the mobile and desktop savvyness of your web performance via Google Pagespeed.
   *
   */

  // Allow pagespeed to be disabled for projects that are not ready for it.
  if (grunt.config('config.performance.pagespeed.disabled')) {
    return;
  }

  grunt.loadNpmTasks('grunt-pagespeed');

  var paths = grunt.config('config.performance.samplePaths') || [ '' ];
  var mobileThreshold = grunt.config('config.performance.pagespeed.threshold.mobile') || 75;
  var deskttopThreshold = grunt.config('config.performance.pagespeed.threshold.desktop') || 85;

  grunt.config('pagespeed', {
    options: {
      nokey: true
    },
    mobile: {
      url: grunt.config('config.siteUrls'),
      locale: 'en_US',
      paths: paths,
      threshold: mobileThreshold
    },
    desktop: {
      url: grunt.config('config.siteUrls'),
      locale: 'en_US',
      paths: paths,
      threshold: desktopThreshold
    }
  });

  grunt.registerTask('performance', [ 'pagespeed' ]);

  var Help = require('../lib/help')(grunt);
  Help.add({
    task: 'test',
    group: 'Testing & Code Quality',
    description: 'Run performance checks & analysis. Some of these are also run as part of the analyze task.'
  });
};
