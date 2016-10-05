module.exports = function(grunt) {
  /**
   * Apply the scaffolding to the Drupal docroot.
   */
  grunt.registerTask('scaffold', 'Apply the scaffolding from ' +
    grunt.config('config.srcPaths.drupal') + '/ to the Drupal docroot.',
    function() {
      var path = require('path');
      if (!require('fs').existsSync(path.join(
        grunt.config('config.buildPaths.html'), 'index.php'))) {
        grunt.fail.fatal('Cannot apply scaffolding until after Drupal has' +
          ' been built.');
      }

      var done = this.async();
      var drupal = require('../lib/drupal')(grunt);
      drupal.loadDrushStatus(function(err) {
        if (err) {
          grunt.fail.fatal('Cannot load Drush status for built Drupal ' +
            'docroot.\n\n' + err);
          return done();
        }

        grunt.loadNpmTasks('grunt-contrib-symlink');

        grunt.config.set('mkdir.drupal', {
          options: {
            create: [
              drupal.libraryPath(),
              drupal.modulePath(),
              drupal.profilePath()
            ]
          }
        });

        grunt.config(['symlink', 'libraries'], {
          expand: true,
          cwd: '<%= config.srcPaths.drupal %>/libraries',
          src: ['*'],
          dest: drupal.libraryPath()
        });
        grunt.config(['symlink', 'modules'], {
          src: '<%= config.srcPaths.drupal %>/modules',
          dest: path.join(drupal.modulePath(), 'custom')
        });
        grunt.config(['symlink', 'profiles'], {
          expand: true,
          cwd: '<%= config.srcPaths.drupal %>/profiles',
          src: ['*'],
          dest: drupal.profilePath(),
          filter: 'isDirectory'
        });
        grunt.config(['symlink', 'sites'], {
          expand: true,
          cwd: '<%= config.srcPaths.drupal %>/sites',
          src: ['*'],
          dest: drupal.sitePath(),
          filter: function(path) {
            return (path !== '<%= config.srcPaths.drupal %>/sites/all');
          }
        });
        grunt.config(['symlink', 'themes'], {
          src: '<%= config.srcPaths.drupal %>/themes',
          dest: path.join(drupal.themePath(), 'custom')
        });

        grunt.task.run([
          'mkdir:drupal',
          'symlink:profiles',
          'symlink:libraries',
          'symlink:modules',
          'symlink:themes',
          'copy:defaults',
          'clean:sites',
          'symlink:sites',
          'mkdir:files',
          'copy:static'
        ]);

        done();
      });
    });

  require('../lib/help')(grunt).add({
    task: 'scaffold',
    group: 'Build Process'
  });
};
