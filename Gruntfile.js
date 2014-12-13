module.exports = function(grunt) {
    // We may want to use grunt to build our grunt tools one day.
    grunt.log.errorlns('Please require `grunt-drupal-tasks/bootstrap` in your Gruntfile.');
    grunt.log.errorlns('Direct use of `grunt-drupal-tasks/Gruntfile.js` is deprecated.');
    require('./bootstrap')(grunt);
}
