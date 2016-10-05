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
      var composer = grunt.file.readJSON(destPath + '/composer.json');
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
    grunt.loadNpmTasks('grunt-shell');

    var config = grunt.config.get('config.packages');
    var srcFiles = (config && config.srcFiles && config.srcFiles.length) ? config.srcFiles : [];
    var projFiles = (config && config.projFiles && config.projFiles.length) ? config.projFiles : [];

    // Look for a package target spec, build destination path.
    var packageName = grunt.option('name') || config.name || 'package';

    // Determine if we are using rsync and vmPath and tarball for performance.
    var useRsync = grunt.config('config.packages.rsync') || false;
    // Determine if we are creating a tarball archive.
    var archive = grunt.config('config.packages.archive') || useRsync;

    // When using rsync, generate to a path that can be mounted in the VM.
    var vmPath = grunt.config.get('config.packages.vmData') || 'build/vm_data';
    var destPath = vmPath + '/' + packageName;
    var finalPath = grunt.config.get('config.buildPaths.packages') + '/' + packageName;
    if (!useRsync) {
      // If not using rsync, then directly generate to final path.
      destPath = finalPath;
    }

    var tasks = [];
    var cleanPaths = [destPath];
    if (destPath !== finalPath) {
      cleanPaths.push(finalPath);
    }
    grunt.option('package-dest', destPath);
    grunt.config.set('clean.packages', cleanPaths);
    tasks.push('clean:packages');

    var excludePaths = ['bower_components', 'node_modules', '.gitkeep'];

    if (useRsync) {
      // Pull negate conditions from srcFiles into excludePaths.
      for (var srcIndex = 0; srcIndex < srcFiles.length; srcIndex++) {
        var item = srcFiles[srcIndex];
        if (item.substr(0, 1) === '!') {
          item = item.slice(1);
          item = item.replace('**', '*');
          excludePaths.push(item);
        }
      }

      // Setup default rsync command and options.
      var rsync = 'rsync -ahWL --no-l --stats --chmod=Du+rwx ';
      for (var pathIndex = 0; pathIndex < excludePaths.length; pathIndex++) {
        rsync = rsync + "--exclude " + excludePaths[pathIndex] + ' ';
      }

      // Ensure destination exists and sent the rsync.
      var srcPath = grunt.config('config.buildPaths.html');
      var destSrc = path.resolve(destPath, grunt.config.get('config.packages.dest.docroot') || '');
      var rsyncCommand = rsync + srcPath + '/ ' + destSrc + '/';

      grunt.config.set('mkdir.package', {
        options: {
          create: [destSrc]
        }
      });

      grunt.config('shell.rsync', {
        command: rsyncCommand
      });
    } else {
      // Use slower copy if rsync is disabled in options.
      srcFiles.unshift('**');
      // Add any additional excludePaths to srcFiles.
      for (var i = 0; i < excludePaths.length; i++) {
        srcFiles.push('!**/' + excludePaths[i]);
      }
      grunt.config('copy.source', {
        files: [
          {
            expand: true,
            cwd: '<%= config.buildPaths.html %>',
            src: srcFiles,
            dest: path.resolve(destPath, grunt.config.get('config.packages.dest.docroot') || ''),
            dot: true,
            follow: true
          }
        ],
        options: {
          gruntLogHeader: false,
          mode: true
        }
      });
    }

    // Always copy any files specified in projFiles.
    grunt.config('copy.package', {
      files: [
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

    if (useRsync) {
      tasks.push('mkdir:package');
      tasks.push('shell:rsync');
    } else {
      tasks.push('copy:source');
    }
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

    if (archive || (this.args[0] && this.args[0] === 'compress')) {
      grunt.loadNpmTasks('grunt-contrib-compress');
      grunt.config('compress.package', {
        options: {
          archive: destPath + '.tgz',
          mode: 'tgz'
        },
        files: [
          {
            expand: true,
            dot: true,
            cwd: destPath,
            src: ['**']
          }
        ]
      });

      tasks.push('compress:package');

      if (destPath !== finalPath) {
        grunt.config('shell.mvArchive', {
          command: 'mv ' + destPath + '.tgz ' + finalPath + '.tgz'
        });
        tasks.push('shell:mvArchive');
      }
    }

    grunt.task.run(tasks);
  });

  Help.add({
    task: 'package',
    group: 'Operations'
  });
};
