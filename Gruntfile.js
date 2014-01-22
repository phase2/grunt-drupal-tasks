module.exports = function(grunt) {

  // Initialize global configuration variables.
  var pkg = grunt.file.readJSON('package.json');
  grunt.initConfig({
    pkg: pkg
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
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.config('clean', {
    default: [
      '<%= pkg.buildPaths.build %>'
    ],
    sites: [
      '<%= pkg.buildPaths.html %>/sites/default'
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
   *       "basePath": "<%= pkg.buildPaths.html %>/sites/all/themes/custom/project"
   *     }
   *   }
   */
  grunt.loadNpmTasks('grunt-contrib-compass');
  if (pkg.compassConfig) {
    for (var key in pkg.compassConfig) {
      if (pkg.compassConfig.hasOwnProperty(key)) {
        grunt.config(['compass', key], {
          options: pkg.compassConfig[key]
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
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.config('copy', {
    static: {
      files: [
        {
          expand: true,
          cwd: 'src/static',
          src: ['*', '.*'],
          dest: '<%= pkg.buildPaths.html %>'
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
  grunt.loadNpmTasks('grunt-contrib-symlink');
  grunt.config('symlink', {
    modules: {
      src: 'src/modules',
      dest: '<%= pkg.buildPaths.html %>/sites/all/modules/custom'
    },
    profiles: {
      expand: true,
      cwd: 'src/profiles',
      src: ['*'],
      dest: '<%= pkg.buildPaths.html %>/profiles',
      filter: 'isDirectory'
    },
    sites: {
      expand: true,
      cwd: 'src/sites',
      src: ['*'],
      dest: '<%= pkg.buildPaths.html %>/sites',
      filter: function (path) {
        return (path !== 'src/sites/all');
      }
    },
    themes: {
      src: 'src/themes',
      dest: '<%= pkg.buildPaths.html %>/sites/all/themes/custom'
    }
  });

  /**
   * Define "drush" tasks.
   *
   * grunt drush:make
   *   Builds the Drush make file to the build/html directory.
   */
  grunt.loadNpmTasks('grunt-drush');
  grunt.config('drush', {
    make: {
      args: ['make', '<%= pkg.srcPaths.make %>'],
      dest: '<%= pkg.buildPaths.html %>'
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
  grunt.loadNpmTasks('grunt-mkdir');
  grunt.config('mkdir', {
    init: {
      options: {
        create: [
          '<%= pkg.buildPaths.build %>/cache',
          '<%= pkg.buildPaths.build %>/docs',
          '<%= pkg.buildPaths.build %>/reports'
        ]
      }
    },
    files: {
      options: {
        create: [
          '<%= pkg.buildPaths.html %>/sites/default/files'
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
