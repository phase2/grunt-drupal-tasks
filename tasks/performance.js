module.exports = function(grunt) {

  /**
   * Manage performance testing and best practices tasks.
   *
   * grunt pagespeed
   *   Evaluate the mobile and desktop savvyness of your web performance via Google Pagespeed.
   *
   */

  // A placeholder task to instruct the use on how to use `grunt performance` properly.
  // This task is overwritten if the site(s) are accessible to Google.
  grunt.registerTask('performance', 'Run checks for performance best practices and raw numbers. Only works with "--web-ready" option.', function() {
    grunt.log.writeln('You must use the --web-ready flag or set the GDT_WEB_READY environment variable to run performance checks.'.yellow);
  });

  var Help = require('../lib/help')(grunt);
  Help.add({
    task: 'performance',
    group: 'Testing & Code Quality',
    description: 'Run checks for performance best practices and raw numbers. Only works with "--web-ready" option.'
  });

  // Check whether the site is web accessible.
  if (!require('../lib/init')(grunt).webReady()) {
    return false;
  }

  grunt.loadNpmTasks('grunt-pagespeed');

  var paths = grunt.config('config.performance.samplePaths') || [ '/' ];
  var mobileThreshold = grunt.config('config.performance.pagespeed.threshold.mobile') || 75;
  var desktopThreshold = grunt.config('config.performance.pagespeed.threshold.desktop') || 85;

  grunt.config('pagespeed', {
    options: {
      nokey: true,
      locale: 'en_US',
      paths: paths
    }
  });

  var urls = grunt.config('config.siteUrls')
  Object.keys(urls).forEach(function(key) {
    grunt.config(['pagespeed', 'desktop-' + key], {
      url: urls[key],
      threshold: desktopThreshold
    });
    grunt.config(['pagespeed', 'mobile-' + key], {
      url: urls[key],
      threshold: mobileThreshold
    });
  });

  grunt.registerTask('performance', [ 'pagespeed' ]);

};
