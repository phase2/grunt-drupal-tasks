module.exports = function(grunt) {

  /**
   * Define "composer" tasks.
   *
   * Dynamically adds a Composer install task if a composer.json file
   * exists in the project directory.
   */
  var config = grunt.config.get('config');
  if (require('fs').existsSync('./composer.json')) {
    grunt.loadNpmTasks('grunt-composer');
    var GDT = require('../lib/gdt')(grunt);

    grunt.config(['composer', 'install'], {});

    GDT.help.add({
      task: 'composer',
      group: 'Dependency Management',
      description: 'Install dependencies defined in this project\'s composer.json file.'
    });
  }
};
