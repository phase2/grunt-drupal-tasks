module.exports = function(grunt) {

  /**
   * Define "package" tasks.
   *
   * grunt package
   *   Builds a deployment package in the build/package directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-contrib-compress/tasks');
  grunt.config('compress', {
    package: {
      options: {
        archive: function () {
          return grunt.config.get('config.buildPaths.package') + '/package-' + new Date().toISOString() + '.tgz';
        },
        mode: 'tgz'
      },
      files: [
        {expand: true, cwd: '<%= config.buildPaths.html %>', src: ['**', '!sites/*/files/**'], dest: 'docroot/'},
        {expand: true, src: ['README*', 'bin/**']}
      ]
    }
  });

  grunt.config('package', {
    tarball: ['compress:package']
  });

  grunt.registerMultiTask('package', 'Package the operational codebase for deployment.', function() {
    grunt.task.run(this.data);
  });
};
