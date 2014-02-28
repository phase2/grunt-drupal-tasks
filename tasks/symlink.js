module.exports = function(grunt) {

  /**
   * Define "symlink" tasks.
   *
   * grunt symlink:modules
   *   Makes a symbolic link to src/modules from sites/all/modules/custom in
   *   the build/html directory.
   *
   * grunt symlink:profiles
   *   Makes symbolic links in the profiles directory in build/html for each
   *   directory in src/profiles.
   *
   * grunt symlink:sites
   *   Makes symbolic links in the sites directory in build/html for all files
   *   and directories in src/sites (except for src/sites/all since the all
   *   directory needs to be preserved).
   *
   * grunt symlink:themes
   *   Makes a symbolic link to src/themes from sites/all/themes/custom in the
   *   build/html directory.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-contrib-symlink/tasks');
  grunt.config('symlink', {
    modules: {
      src: 'src/modules',
      dest: '<%= config.buildPaths.html %>/sites/all/modules/custom'
    },
    profiles: {
      expand: true,
      cwd: 'src/profiles',
      src: ['*'],
      dest: '<%= config.buildPaths.html %>/profiles',
      filter: 'isDirectory'
    },
    sites: {
      expand: true,
      cwd: 'src/sites',
      src: ['*'],
      dest: '<%= config.buildPaths.html %>/sites',
      filter: function (path) {
        return (path !== 'src/sites/all');
      }
    },
    themes: {
      src: 'src/themes',
      dest: '<%= config.buildPaths.html %>/sites/all/themes/custom'
    }
  });

};
