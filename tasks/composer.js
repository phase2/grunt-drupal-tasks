module.exports = function(grunt) {

  /**
   * Define "composer" tasks.
   *
   * Dynamically adds a Composer install task if a composer.json file
   * exists in the project directory.
   */
  var config = grunt.config.get('config');
  grunt.loadNpmTasks('grunt-newer');
  if (require('fs').existsSync('./composer.json')) {
    grunt.loadNpmTasks('grunt-composer');
    var Help = require('../lib/help')(grunt);

    grunt.config(['composer', 'install'], {});

    Help.add({
      task: 'composer',
      group: 'Dependency Management',
      description: 'Install dependencies defined in this project\'s composer.json file.'
    });

    grunt.registerTask('composerinstall', 'Prepare the build directory and run "composer install"', function() {
      grunt.task.run('mkdir:init', 'clean:temp', 'composer:install', 'clean:default', 'copy:tempbuild', 'clean:temp');
    });

    // The "composerinstall" task will run make only if the src file specified here is
    // newer than the dest file specified.
    grunt.config('composerinstall', {
      default: {
        src: './composer.json',
        dest: '<%= config.buildPaths.html %>'
      }
    });

    Help.add([
      {
        task: 'composerinstall',
        group: 'Dependency Management'
      },
      {
        task: 'newer',
        group: 'Dependency Management',
        description: 'Use "newer:composerinstall" to run the composerinstall task only if the composer.json file was updated.'
      }
    ]);
  }
};
