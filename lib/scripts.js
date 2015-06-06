module.exports = function(grunt) {
  var module = {};

  module.handle = function(config, task, namespace) {
    var command = '';

    if (task == undefined) {
      if (config.scripts == undefined) {
        grunt.log.writeln("No scripts have been configured.");
      }
      else {
        module.usage(config.scripts);
      }
      return command;
    }

    if (config.scripts[task]) {
      grunt.config(['shell', namespace + '-dispatch'], {
        command: config.scripts[task],
        options: {
          execOptions: {
            cwd: config.path
          },
          gruntLogHeader: false
        }
      });
      command = 'shell:' + namespace + '-dispatch';
    }
    else {
      grunt.log.writeln('The ' + namespace + ' command "' + task + '"" is not available. Select from the following:');
      module.usage(config.scripts);
    }

    return command;
  }

  module.usage = function(scripts) {
    for (var key in scripts) {
      grunt.log.writeln(key + '\t:\t' + scripts[key]);
    }
  }

  return module;
}
