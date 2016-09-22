module.exports = function(grunt) {
  /**
   * Define "package" tasks.
   *
   * grunt package
   *   Builds a deployment package in the build/package directory.
   */

  var Help = require('../lib/help')(grunt);
  var path = require('path');

  grunt.registerTask('packageRewriteComposer', '', function() {
    var pathBuild = grunt.config('config.buildPaths.html');
    var pathPackage = grunt.config('config.packages.dest.docroot');
    // Check if we are packaging to a custom destination.
    if (pathBuild !== pathPackage) {
      var changed = false;
      var regex = new RegExp('^' + pathBuild);
      // Load `composer.json` as JSON, convert to object.
      var composer = grunt.file.readJSON('composer.json');
      for (var key in composer.extra['installer-paths']) {
        var newKey = key.replace(regex, pathPackage);
        if (newKey != key) {
          // Alter keys in `extra.installer-paths` object to change `build/html`
          // to `html` or an alternative path from the config.
          var value = composer.extra['installer-paths'][key];
          delete composer.extra['installer-paths'][key];
          composer.extra['installer-paths'][newKey] = value;
          changed = true;
        }
      }
      if (changed) {
        // Write out data to `composer.json` in the package output.
        var composerString = JSON.stringify(composer, null, 2);
        grunt.file.write('composer.json', composerString);
      }
    }
  });

  grunt.registerTask('package', 'Package the operational codebase for deployment. Use package:compress to create an archive.', function() {
    grunt.loadNpmTasks('grunt-contrib-copy');

    var config = grunt.config.get('config.packages');
    var srcFiles = ['**', '!**/.gitkeep'].concat((config && config.srcFiles && config.srcFiles.length) ? config.srcFiles : '**');
    var projFiles = (config && config.projFiles && config.projFiles.length) ? config.projFiles : [];

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
          dest: path.resolve(destPath, grunt.config.get('config.packages.dest.docroot') || ''),
          dot: true,
          follow: true
        },
        {
          expand: true,
          src: projFiles,
          dest: path.resolve(destPath, grunt.config.get('config.packages.dest.devResources') || ''),
          dot: true,
          follow: true
        }
      ],
      options: {
        gruntLogHeader: false,
        mode: true
      }
    });

    grunt.config.set('clean.packages', [destPath]);

    tasks.push('clean:packages');
    tasks.push('copy:package');

    // If the `composer.json` file is being packaged, rebuild composer dependencies without dev.
    if (projFiles.find(function(pattern) {
      return pattern.startsWith('composer');
    })) {
      tasks.push('packageRewriteComposer');
      grunt.config(['composer'], {
        options: {
          flags: ['no-dev'],
          cwd: destPath
        }
      });
      tasks.push('composer:install');
    }

    if (this.args[0] && this.args[0] === 'compress') {
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
            src: ['**']
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
