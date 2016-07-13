module.exports = function(grunt) {
  /**
   * Define "help" task, a more purposeful and structured help than -h.
   *
   * grunt help
   *   Provides an overview of intended and useful grunt tasks.
   */
  var _ = require('lodash');

  var Help = require('../lib/help')(grunt);

  Help.add({
    task: 'default',
    group: 'Build Process',
    description: 'The default build process that executes when "grunt" runs, which includes verifying dependencies and assembling the build directory.'
  });

  // Specify that only configured help entries should be displayed.
  grunt.config('availabletasks.help.options.filter', 'include');

  // Suppress task headings for help to keep it lean.
  grunt.config('help.options.gruntLogHeader', false);
  grunt.config('availabletasks.help.options.gruntLogHeader', false);
  grunt.config('help-after.options.gruntLogHeader', false);

  grunt.registerTask('help', 'Output grunt-drupal-tasks specialized help.', function() {
    var gdt = {};
    var gruntHelp = require('grunt/lib/grunt/help');
    var process = function(queue) {
      queue.forEach(function(cb) {
        cb();
      });
    };

    gdt.cleanOptions = function() {
      _.each(gruntHelp._options, function(item, i) {
        if (item[0] === '--base' || item[0] === '--gruntfile' || item[0] === '--tasks' || item[0] === '--npm') {
          delete gruntHelp._options[i];
        }
        if (item[0] === '--help, -h') {
          gruntHelp._options[i][1] = 'Display the default Grunt help text.';
        }
      });
    };

    gdt.header = function() {
      grunt.log.writeln('Used with Grunt Drupal Tasks (v' + require('../package.json').version + ')');
      grunt.log.writeln().writeln('To display this help, run `grunt help`');
    };

    gdt.options = function() {
      var options = [
        ['--concurrency', 'Override the dynamic concurrency parameter used by Drush Make.'],
        ['--db-url', 'Pass thru your Drupal database credentials for site installation.'],
        ['--name', 'Override the name of the package exported by "grunt package".'],
        ['--notify', 'Request a desktop notification despite timing or environment settings.'],
        ['--no-validate', 'Skip `grunt:validate` in the default `grunt` task.'],
        ['--quiet', 'Suppress desktop notifications.'],
        ['--timer', 'Output task execution timing info.']
      ];

      if (grunt.config('config.project.db')) {
        options.push('--no-db-load', 'Perform a clean site installation even if a database restore path is configured');
      }

      gruntHelp.table(options);
    };

    gdt.tasks = function() {
      grunt.loadNpmTasks('grunt-available-tasks');
      grunt.task.run('availabletasks:help', 'help-after');
    };

    gdt.footer = function() {
      grunt.log.writeln('For help with Grunt Drupal Tasks, see ' + require('../package.json').homepage);
    };

    // Dispatch to grunt tasks is asynchronous, in order to display text after
    // dispatching to availabletasks we need a dedicated task so grunt's internal
    // task sequencing will ensure the proper order of execution.
    grunt.registerTask('help-after', 'Generate a footer to follow primary help text.', function() {
      var queue = [
        gruntHelp.footer,
        gdt.footer
      ];
      process(queue);
    });

    var queue = [
      gruntHelp.initOptions,
      gdt.cleanOptions,
      gruntHelp.initWidths,
      gruntHelp.header,
      gdt.header,
      gruntHelp.usage,
      gruntHelp.options,
      gdt.options,
      gruntHelp.optionsFooter,
      gdt.tasks
    ];

    process(queue);
  });
};
