module.exports = function(grunt) {
  var module = {};

  module.addItem = function(task, group, description) {
    // Add task to the list of those displayed by `grunt help`.
    var tasks = grunt.config('availabletasks.help.options.tasks');
    if (tasks === undefined) {
      tasks = [];
    }
    tasks.push(task);
    grunt.config('availabletasks.help.options.tasks', tasks);

    // Assign the task to the specified group.
    if (group) {
      var groups = grunt.config('availabletasks.help.options.groups');
      if (groups === undefined) {
        groups = {};
      }
      if (groups[group] === undefined) {
        groups[group] = [];
      }
      groups[group].push(task);
      grunt.config('availabletasks.help.options.groups', groups);
    }

    // Override the task description.
    if (description) {
      grunt.config('availabletasks.help.options.descriptions.' + task, description);
    }
  };

  module.add = function(items) {
    if (items instanceof Array) {
      items.forEach(function(item) {
        module.addItem(item.task, item.group, item.description);
      });
    } else if (items instanceof Object) {
      module.addItem(items.task, items.group, items.description);
    }
  };

  return module;
};
