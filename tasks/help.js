module.exports = function(grunt) {

  /**
   * Define "help" task, a more purposeful and structured help than -h.
   *
   * grunt help
   *   Provides an overview of intended and useful grunt tasks.
   */

  grunt.loadNpmTasks('grunt-available-tasks');
  var gdt = require('../lib/gdt')(grunt);

  gdt.help.add({
    task: 'default',
    group: 'Build Process',
    description: 'The default build process that executes when "grunt" runs, which includes verifying dependencies and assembling the build directory.'
  });

  grunt.config(['availabletasks', 'help'], {
    options: {
      filter: 'include',
    }
  });

  console.log(gdt);

  grunt.registerTask('help', ['availabletasks:help']);
};
