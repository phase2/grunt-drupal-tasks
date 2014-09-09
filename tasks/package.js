module.exports = function(grunt) {

  /**
   * Define "package" tasks.
   *
   * grunt package
   *   Builds a deployment package in the build/package directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-contrib-compress/tasks');
  var config = grunt.config.get('config'),
    srcFiles = (config.packages && config.packages.srcFiles && config.packages.srcFiles.length) ? config.packages.srcFiles : [],
    projFiles = (config.packages && config.packages.projFiles && config.packages.projFiles.length) ? config.packages.projFiles : [];
  grunt.config('compress', {
    package: {
      options: {
        archive: function () {
          return grunt.config.get('config.buildPaths.package') + '/package-' + new Date().toISOString() + '.tgz';
        },
        mode: 'tgz'
      },
      files: [
        {
          expand: true,
          cwd: '<%= config.buildPaths.html %>',
          src: ['**'].concat(srcFiles),
          dest: 'docroot/'
        },
        {
          expand: true,
          src: projFiles
        }
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
