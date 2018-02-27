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
    var pathVendor = grunt.config('config.packages.dest.vendor');
    // Check if we are packaging to a custom destination.
    if ((pathBuild !== pathPackage) || pathVendor) {
      // Load `composer.json` as JSON, convert to object.
      var destPath = grunt.option('package-dest');
      var composer = grunt.file.readJSON('composer.json');
      // Determine new installer-paths
      var pathInstall = pathPackage ? pathPackage + '/' : '';
      if (pathVendor) {
        // Make sure install path is relative to vendor location.
        var regexVendor = new RegExp('^' + pathVendor + '/');
        pathInstall = pathInstall.replace(regexVendor, '');
      }
      var regex = new RegExp('^' + pathBuild + '/');
      for (var key in composer.extra['installer-paths']) {
        // Add an unnecessary if check just for eslint rules.
        if (composer.extra['installer-paths'].hasOwnProperty(key)) {
          var newKey = key.replace(regex, pathInstall);
          if (newKey !== key) {
            // Alter keys in `extra.installer-paths` object to change `build/html`
            // to `html` or an alternative path from the config.
            var value = composer.extra['installer-paths'][key];
            delete composer.extra['installer-paths'][key];
            composer.extra['installer-paths'][newKey] = value;
          }
        }
      }

      // Next, generate the composer.json in the correct path.
      var destComposer = (pathVendor) ? destPath + '/' + pathVendor : destPath;
      // Write out data to `composer.json` in the package output.
      var composerString = JSON.stringify(composer, null, 2);
      grunt.file.write(destComposer + '/composer.json', composerString);
      if (pathVendor) {
        // Remove the original file if we moved it.
        grunt.file.delete(destPath + '/composer.json');
        // Change working directory for later `composer install`.
        grunt.config(['composer'], {
          options: {
            flags: ['no-dev'],
            cwd: destComposer
          }
        });
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
    grunt.option('package-dest', destPath);

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
      grunt.config(['composer', 'drupal-scaffold'], {});
      tasks.push('composer:drupal-scaffold');
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
