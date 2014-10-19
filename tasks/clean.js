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
  grunt.loadTasks(__dirname + '/../node_modules/grunt-contrib-clean/tasks');
  grunt.config('clean', {
    default: [
      '<%= config.buildPaths.build %>'
    ],
    sites: [
      '<%= config.buildPaths.html %>/sites/default'
    ]
  });

  grunt.config('help.clean', {
    group: 'Utilities'
  });
};
