module.exports = function(grunt) {

  /**
   * Define "Bundler" tasks.
   *
   * If a Gemfile is defined in the repository root, add a grunt task to run
   * "bundle install".
   */

  if (grunt.file.exists('Gemfile')) {
    grunt.registerTask('bundle-install', 'Run `bundle install`, dropping symlinks to all binaries in `gems/bin`.', function() {
      grunt.loadNpmTasks('grunt-shell');
      grunt.config(['shell', 'bundle-install'], {
        command: "bundle install --binstubs=gems/bin"
      });
    });

    // camelCase is deprecated.
    grunt.registerTask('bundleInstall', ['shell:bundle-install']);  

    grunt.config('help.bundle-install', {
      group: 'Dependency Management',
      description: 'Run `bundle install`, dropping symlinks to all binaries in `gems/bin`.'
    });
  }
};
