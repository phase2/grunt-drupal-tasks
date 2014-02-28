module.exports = function(grunt) {

  // Initialize global configuration variables.
  var config = grunt.file.readJSON('Gruntconfig.json');
  grunt.initConfig({
    config: config
  });

  /**
   * Define "clean" tasks to remove files and directories.
   *
   * grunt clean
   *   Removes build directory.
   *
   * grunt clean:sites
   *   Removes sites/default in the build/html directory.
   */
  grunt.loadTasks(__dirname + '/node_modules/grunt-contrib-clean/tasks');
  grunt.config('clean', {
    default: [
      '<%= config.buildPaths.build %>'
    ],
    sites: [
      '<%= config.buildPaths.html %>/sites/default'
    ]
  });

  /**
   * Define "compass" tasks.
   *
   * Dynamically adds Compass compile tasks based on configuration sets in the
   * package.json file.
   *
   * Example:
   *   "compassConfig": {
   *     "project": {
   *       "basePath": "<%= config.buildPaths.html %>/sites/all/themes/custom/project"
   *     }
   *   }
   */
  grunt.loadTasks(__dirname + '/node_modules/grunt-contrib-compass/tasks');
  if (config.compassConfig) {
    for (var key in config.compassConfig) {
      if (config.compassConfig.hasOwnProperty(key)) {
        grunt.config(['compass', key], {
          options: config.compassConfig[key]
        });
      }
    }
  }

  /**
   * Define "copy" tasks.
   *
   * grunt copy:static
   *   Copies all files from src/static to the build/html directory.
   */
  grunt.loadTasks(__dirname + '/node_modules/grunt-contrib-copy/tasks');
  grunt.config('copy', {
    static: {
      files: [
        {
          expand: true,
          cwd: 'src/static',
          src: ['*', '.*'],
          dest: '<%= config.buildPaths.html %>'
        }
      ]
    }
  });

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
  grunt.loadTasks(__dirname + '/node_modules/grunt-contrib-symlink/tasks');
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

  /**
   * Define "drush" tasks.
   *
   * grunt drush:make
   *   Builds the Drush make file to the build/html directory.
   */
  grunt.loadTasks(__dirname + '/node_modules/grunt-drush/tasks');
  grunt.config('drush', {
    make: {
      args: ['make', '<%= config.srcPaths.make %>'],
      dest: '<%= config.buildPaths.html %>'
    }
  });

  /**
   * Define "mkdir" tasks.
   *
   * grunt mkdir:init
   *   Creates directories expected in the build directory.
   *
   * grunt mkdir:files
   *   Creates sites/default/files in the build/html directory.
   */
  grunt.loadTasks(__dirname + '/node_modules/grunt-mkdir/tasks');
  grunt.config('mkdir', {
    init: {
      options: {
        create: [
          '<%= config.buildPaths.build %>/cache',
          '<%= config.buildPaths.build %>/docs',
          '<%= config.buildPaths.build %>/reports'
        ]
      }
    },
    files: {
      options: {
        create: [
          '<%= config.buildPaths.html %>/sites/default/files'
        ]
      }
    }
  });

  // Define the default task to fully build and configure the project.
  var tasksDefault = ['clean:default', 'mkdir:init', 'drush:make', 'symlink:profiles', 'symlink:modules', 'symlink:themes', 'clean:sites', 'symlink:sites', 'mkdir:files', 'copy:static'];
  if (grunt.config.get('compass')) {
    tasksDefault.push('compass');
  }
  grunt.registerTask('default', tasksDefault);

};
