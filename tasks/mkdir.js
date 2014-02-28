module.exports = function(grunt) {

  /**
   * Define "mkdir" tasks.
   *
   * grunt mkdir:init
   *   Creates directories expected in the build directory.
   *
   * grunt mkdir:files
   *   Creates sites/default/files in the build/html directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-mkdir/tasks');
  grunt.config('mkdir', {
    init: {
      options: {
        create: [
          '<%= config.buildPaths.build %>/cache',
          '<%= config.buildPaths.build %>/docs',
          '<%= config.buildPaths.build %>/reports'
        ]
      }
    },
    files: {
      options: {
        create: [
          '<%= config.buildPaths.html %>/sites/default/files'
        ]
      }
    }
  });

};
