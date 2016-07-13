module.exports = function(grunt) {
  var module = {};

  var buildCmd = function(name, cmd, execOptions) {
    grunt.loadNpmTasks('grunt-shell');
    grunt.config(['shell', name + '-dispatch'], {
      command: cmd,
      options: {
        gruntLogHeader: false
      }
    });

    if (execOptions) {
      grunt.config(['shell', name + '-dispatch', 'options', 'execOptions'], execOptions);
    }

    return 'shell:' + name + '-dispatch';
  };

  /**
   * Generate configuration and retrieve commands for an arbitrary task name.
   * Useful to add configuration-driven "events" to other tasks.
   */
  module.eventify = function(scripts, task, namespace, tasks) {
    if (!scripts) {
      return tasks;
    }

    var command;
    if (scripts['pre-' + task]) {
      command = buildCmd('pre-' + namespace, scripts['pre-' + task]);
      tasks.unshift(command);
    }
    if (scripts['post-' + task]) {
      command = buildCmd('post-' + namespace, scripts['post-' + task]);
      tasks.push(command);
    }

    return tasks;
  };

  // Generate configuration and retrieve commands for a defined script task.
  module.handle = function(config, task, namespace) {
    var command = '';

    if (task === undefined) {
      if (config.scripts === undefined) {
        grunt.log.writeln("No scripts have been configured.");
      } else {
        module.usage(config.scripts);
      }
      return command;
    }

    if (config.scripts[task]) {
      command = [];
      if (config.scripts['pre-' + task]) {
        command.push(buildCmd(
          'pre-' + namespace,
          config.scripts['pre-' + task],
          {
            cwd: config.path || process.cwd()
          }
        ));
      }
      command.push(buildCmd(
        namespace,
        config.scripts[task],
        {
          cwd: config.path || process.cwd()
        }
      ));
      if (config.scripts['post-' + task]) {
        command.push(buildCmd(
          'post-' + namespace,
          config.scripts['post-' + task],
          {
            cwd: config.path || process.cwd()
          }
        ));
      }
    } else {
      grunt.log.writeln('The ' + namespace + ' command "' + task + '"" is not available. Select from the following:');
      module.usage(config.scripts);
    }

    return command;
  };

  module.usage = function(scripts) {
    var _ = require('lodash');
    _.each(scripts, function(script, key) {
      grunt.log.writeln(key + '\t:\t' + scripts[key]);
    });
    grunt.log.writeln('Scripts named with "pre-<op>" or "post-<op>" are automatically run before or after their respective <op> operation.');
  };

  return module;
};
