module.exports = function(grunt) {

  /**
   * Define "Bundler" tasks.
   *
   * If a Gemfile is defined in the repository root, add a grunt task to run
   * "bundle install".
   */
  grunt.loadNpmTasks('grunt-shell');
  var Help = require('../lib/help')(grunt);

  if (grunt.file.exists('Gemfile')) {
    grunt.config(['shell', 'bundle-install'], {
      command: "bundle install --binstubs=vendor/bin --path=vendor/bundle"
    });
    grunt.registerTask('bundleInstall', ['shell:bundle-install']);
    grunt.registerTask('bundle-install', ['shell:bundle-install']);

    Help.add({
      task: 'bundle-install',
      group: 'Dependency Management',
      description: 'Run `bundle install`, dropping symlinks to all binaries in `gems/bin`.'
    });
  }
};
