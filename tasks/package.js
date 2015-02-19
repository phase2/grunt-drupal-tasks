module.exports = function(grunt) {

  /**
   * Define "package" tasks.
   *
   * grunt package
   *   Builds a deployment package in the build/package directory.
   */
  var config = grunt.config.get('config'),
  srcFiles = (config.packages && config.packages.srcFiles && config.packages.srcFiles.length) ? config.packages.srcFiles : [],
  projFiles = (config.packages && config.packages.projFiles && config.packages.projFiles.length) ? config.packages.projFiles : [];
  grunt.config('compress', {
    package: {
      options: {
        archive: function () {
          return grunt.config.get('config.buildPaths.package') + '/package.tgz';
        },
        mode: 'tgz'
      },
      files: [
        {
          expand: true,
          dot: true,
          cwd: '<%= config.buildPaths.html %>',
          src: ['**', '!**/.gitkeep'].concat(srcFiles),
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
    grunt.loadNpmTasks('grunt-contrib-compress');
    grunt.task.run(this.data);
  });

  grunt.config('help.package', {
    group: 'Operations'
  });
};
