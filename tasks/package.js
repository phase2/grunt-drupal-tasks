module.exports = function(grunt) {

  /**
   * Define "package" tasks.
   *
   * grunt package
   *   Builds a deployment package in the build/package directory.
   */

  var Help = require('../lib/help')(grunt);

  grunt.registerTask('package', 'Package the operational codebase for deployment. Use package:compress to create an archive.', function() {
    var path = require('path');
    grunt.loadNpmTasks('grunt-contrib-copy');

    var config = grunt.config.get('config.packages'),
      srcFiles = ['**', '!**/.gitkeep'].concat((config && config.srcFiles && config.srcFiles.length) ? config.srcFiles : '**'),
      projFiles = (config && config.projFiles && config.projFiles.length) ? config.projFiles : [];

    // Look for a package target spec, build destination path.
    var packageName = grunt.option('name') || config.name || 'package';
    var destPath = grunt.config.get('config.buildPaths.packages') + '/' + packageName;
    var tasks = [];

    grunt.config('copy.package', {
      files: [
        {
          expand: true,
          cwd: '<%= config.buildPaths.html %>',
          src: srcFiles,
          dest: destPath + (grunt.config.get('config.packages.dest.docroot') || ''),
          dot: true,
          follow: true
        },
        {
          expand: true,
          src: projFiles,
          dest: destPath + (grunt.config.get('config.packages.dest.devResources') || ''),
          dot: true,
          follow: true
        }
      ],
      options: {
        gruntLogHeader: false,
        mode: true
      }
    });

    grunt.config.set('clean.packages', [ destPath ]);

    tasks.push('clean:packages');
    tasks.push('copy:package');

    if (this.args[0] && this.args[0] == 'compress') {
      grunt.loadNpmTasks('grunt-contrib-compress');
      grunt.config('compress.package', {
        options: {
          archive: destPath + '.tgz',
          mode: 'tgz',
          gruntLogHeader: false
        },
        files: [
          { 
            expand: true,
            dot: true,
            cwd: grunt.config.get('config.buildPaths.packages') + '/' + packageName,
            src: ['**'],
          }
        ]
      });

      tasks.push('compress:package');
    }

    grunt.task.run(tasks);
  });

  Help.add({
    task: 'package',
    group: 'Operations'
  });

};
