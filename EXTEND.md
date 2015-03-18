# Extending Drupal Grunt Build and Testing Tasks

This is a guide for advanced project-specific extensions to Drupal Grunt Build
and Testing Tasks and for contributing changes to the core tasks.

## Project-specific extensions

### Changing the build process

There are two ways to change the default build process (which is run when simply
typing `grunt` into the command-line.)

1. Replicate the definition of the default task you can see in this
   grunt-drupal-tasks' bootstrap.js. This will completely replace what currently
   exists.
2. Use a slick workaround that allows you to keep the default task as it's been
   defined, but append or prepend your own operations. See below for a simple
   example.

```js
grunt.task.renameTask('default', 'default-original');
grunt.registerTask('default', ['shell:custom', 'default-original']);
```

### Adding new tasks

To add additional tasks to your project's grunt implementation, you may define
them directly in your Gruntfile.js or include them from separate files.

#### Load a plugin managed by npm

```js
grunt.loadNpmTasks('grunt-plugin-name');
```

#### Load a local grunt plugin

```js
grunt.loadTasks(__dirname + '/grunt/tasks');
```

### Overriding existing tasks

To override an existing task the trick is to add code that will be the final
piece to adjust the configuration of the task. This may be a specific
configuration element, or a redefinition of the entire task.

#### Override a task's configuration

In your project's `Gruntfile.js`, use the `grunt.config.set()` function to
override the task's default configuration provided by Grunt Drupal Tasks.

The following example changes the list of files scanned by the `phplint:all`
command:

```js
grunt.config.set('phplint', {
  all: [
    '<%= config.srcPaths.drupal %>/**/*.php'
  ]
});
```

#### Re-register the validate task

In your project's `Gruntfile.js`, use the `grunt.registerTask()` function to
override task aliases, like default, validate, and analyze.

The following example changes the list of tasks run by the `validate` command:

```js
var taskList = ['phpcs:full'];
grunt.registerTask('validate', taskList);
```

### Leveraging Bash Scripts

If you have an existing project or a kit of useful project utilities, you may
have some Bash scripts laying around that you want to keep. You can fold them
into the grunt tools and worry about reimplementing them later using something
like the simple wrapper script based on
[grunt-shell](https://github.com/sindresorhus/grunt-shell) displayed below.

```js
module.exports = function(grunt) {
 
/**
 * Define "bin" wrapper tasks.
 */
var files = grunt.file.expand("bin/*.sh");
if (files) {
  for (var f in files) {
    var name = files[f].split('/').pop().split('.').shift();
      grunt.config(['shell', name], {
        command: 'bash ' + files[f]
      });
      grunt.registerTask(name, ['shell:' + name]);
    }
  }
};
```
This particular snippet requires your bash scripts end in `.sh` and be located
in the directory `root:bin/`.

## Contributing

If you would like to contribute to this project, here are a few considerations.

### Adding a New Task

Adding a new task should only be done if a majority of projects should use that
functionality. Really cool tasks that seem useful for less than 80% of Drupal
projects using this system should be a separate project. Different projects can
still follow the philosophy of `grunt-drupal-tasks` and will happily be linked
if we think they have high value.

A task should be defined in a file under the `tasks/` directory. We prefer to
see `taskname.js` as the name, unless there is a group of closely related tasks,
such as the existing `theme.js`.

### Modifying the Default Build Process

If you want to propose a change to the default build process, this change should
be:

- Universally relevant to all projects using the tasks.

- If unconditionally added to the build, based on documented, required
  configuration.

- If conditionally added to the build, make sure that condition checks that the
  task is properly configured. Look at `bootstrap.js` for examples of
  conditional steps.

### Things to Consider

- There can be multiple modules, themes, profiles, libraries, and sites. New
  tasks should take that into account. The `theme.js` file demonstrates using
  configuration to allow projects to opt themes individually into SASS
  processing.

- The tasks in the main build process should provide command-line results for
  ease of developer troubleshooting.

- Changes to the directory structure or subtractions/renames in the supported
  Grunt configuration are considered backwards compatibility breaks.
