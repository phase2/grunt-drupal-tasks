module.exports = function(grunt) {

  /**
   * Define "clean" tasks to remove files and directories.
   *
   * grunt clean
   *   Removes build directory.
   *
   * grunt clean:sites
   *   Removes sites/default in the build/html directory.
   */
  grunt.loadNpmTasks('grunt-contrib-clean');
  var GDT = require('../lib/gdt')(grunt);

  grunt.config('clean', {
    default: [
      '<%= config.buildPaths.html %>'
    ],
    sites: [
      '<%= config.buildPaths.html %>/sites/default'
    ],
    temp: [
      '<%= config.buildPaths.temp %>'
    ]
  });

  GDT.help.add({
    task: 'clean',
    group: 'Utilities',
    description: 'Use "clean" to remove the build output directory.'
  });
};
