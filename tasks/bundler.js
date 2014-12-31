module.exports = function(grunt) {

  /**
   * Define "Bundler" tasks.
   *
   * If a Gemfile is defined in the repository root, add a grunt task to run
   * "bundle install".
   */
  grunt.loadNpmTasks('grunt-shell');

  if (grunt.file.exists('Gemfile')) {
    grunt.config(['shell', 'bundle-install'], {
      command: "bundle install --binstubs=gems/bin"
    });
    grunt.registerTask('bundleInstall', ['shell:bundleInstall']);
    grunt.registerTask('bundle-install', ['shell:bundleInstall']);

    grunt.config('help.bundle-install', {
      group: 'Dependency Management',
      description: 'Run `bundle install`, dropping symlinks to all binaries in `gems/bin`.'
    });
  }
};
