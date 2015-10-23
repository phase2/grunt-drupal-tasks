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

    var config = grunt.config.get('config.packages.default'),
      srcFiles = ['**', '!**/.gitkeep'].concat((config && config.srcFiles && config.srcFiles.length) ? config.srcFiles : '**'),
      projFiles = (config && config.projFiles && config.projFiles.length) ? config.projFiles : [];

    var destPath = grunt.config.get('config.buildPaths.package') + '/package';
    var tasks = []

    // Figure out if we are building a vendor-specific package.
    var buildTarget = grunt.option('target') || process.env.GRUNT_PACKAGE_TARGET;
    if (buildTarget && isValidTarget(buildTarget)) {
      grunt.config('config.buildTarget', grunt.option('target'))
    }
    else {
      grunt.config('config.buildTarget', 'default');
    }
    grunt.log.writeln('Building package for ' + grunt.config.get('config.buildTarget'));

    var validTarget = grunt.config.get('config.buildTarget');

    // Build the specified vendor target, or the default.
    switch (validTarget) {
      case 'acquia':
        /**
         * Acquia release build tasks.
         */
        grunt.config.merge({
          copy: { 'acquia_docroot': {
            files: [
              {
                expand: true,
                cwd: '<%= config.buildPaths.html %>',
                src: '<%= config.packages.acquia.srcFiles %>',
                dest: '<%= config.packages.acquia.paths.docroot %>'
              }
            ]
          }}
        });
        grunt.config.merge({
          copy: { 'acquia_shared': {
            files: [
              {
                expand: true,
                cwd: '<%= config.buildPaths.html %>/sites/default',
                src: '<%= config.packages.acquia.sharedFiles %>',
                dest: '<%= config.packages.acquia.paths.shared %>'
              }
            ]
          }}
        });

        /**
         * Acquia clean tasks.
         */
        grunt.config.merge({
          clean: {
            'acquia_docroot': '<%= config.packages.acquia.paths.docroot %>',
            'acquia_shared': '<%= config.packages.acquia.paths.shared %>'
          }
        });

        /**
         * Symlink shared files (settings, etc) that is not part of docroot.
         */
        grunt.loadNpmTasks('grunt-contrib-symlink');
        grunt.config(['symlink', 'shared'], {
          expand: true,
          cwd: '<%= config.packages.acquia.paths.shared %>',
          src: ['*'],
          dest: '<%= config.packages.acquia.paths.docroot %>/sites/default/'
        });

        tasks.push('clean:acquia_docroot');
        tasks.push('clean:acquia_shared');
        tasks.push('copy:acquia_docroot');
        tasks.push('copy:acquia_shared');
        tasks.push('symlink:shared');

        break;

      default:
        grunt.config('copy.package', {
          files: [
            {
              expand: true,
              cwd: '<%= config.buildPaths.html %>',
              src: srcFiles,
              dest: destPath + (grunt.config.get('config.packages.dest.docroot') || ''),
              dot: true
            },
            {
              expand: true,
              src: projFiles,
              dest: destPath + (grunt.config.get('config.packages.dest.devResources') || ''),
              dot: true
            }
          ],
          options: {
            gruntLogHeader: false
          }
        });

        tasks.push('copy:package');

    }

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
            cwd: grunt.config.get('config.buildPaths.package'),
            src: 'package/**',
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

  function isValidTarget(target) {
    if (target.length) {
      var validTargets = ['acquia'];
      return (validTargets.indexOf(target) > -1);
    }
    else {
      return false;
    }
  }

};
