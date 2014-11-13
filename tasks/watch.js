module.exports = function(grunt) {

  /**
   * Define "watch" tasks.
   *
   * Add a watch task that automatically runs the test suite when a file in
   * the Drupal docroot changes (except for files in sites/.../files) or when
   * a file in the testing features directory changes.
   */
  grunt.loadTasks(__dirname + '/../node_modules/grunt-contrib-watch/tasks');
  grunt.config(['watch', 'behat'], {
    files: [
      '<%= config.srcPaths.drupal %>/**/*',
      '!<%= config.srcPaths.drupal %>/sites/*/files/**/*',
      'features/**/*'
    ],
    tasks: ['behat']
  });
  grunt.config(['watch', 'validate'], {
    files: [
      '<%= config.srcPaths.drupal %>/**/*',
      '!<%= config.srcPaths.drupal %>/**/*.features.*inc',
      '!<%= config.srcPaths.drupal %>/sites/**'
    ],
    tasks: ['validate']
  });

  // Watch SASS files for changes, if there is run compile-theme task.
  // A more fine-grained task may be needed later if more non-SASS elements are
  // added to the compile-theme task.
  grunt.config(['watch', 'compass'], {
    files: [
      '<%= config.srcPaths.drupal %>/themes/{,**/}*.{sass,scss}'
    ],
    tasks: ['compile-theme']
  });

  // Add a watch task to Livereload CSS files after compilation
  grunt.config(['watch', 'css'], {
    options: {
      livereload: true
    },
    files: [
      '<%= config.srcPaths.drupal %>/themes/{,**/}*.css'
    ]
  });

  // Initialize parallel
  grunt.config(['parallel', 'watch-theme'], {
    options: {
      stream: true
    },
    tasks: [
      {
        grunt: true,
        args: ['watch:compass']
      },
      {
        grunt: true,
        args: ['watch:css']
      }
    ]
  });

  grunt.config(['parallel', 'watch-test'], {
    options: {
      stream: true
    },
    tasks: [
      {
        grunt: true,
        args: ['watch:validate']
      },
      {
        grunt: true,
        args: ['watch:behat']
      }
    ]
  });

  grunt.registerTask('watch-test', ['parallel:watch-test']);

  grunt.config('watch-test', {
    group: 'Real-time Tooling'
  });
  grunt.config('watch-theme', {
    group: 'Real-time Tooling'
  });
}
