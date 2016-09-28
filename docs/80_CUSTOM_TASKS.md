# Extending Grunt Drupal Tasks

> Guide for advanced project-specific extensions to Grunt Drupal Tasks.

## Adding new tasks

To add additional tasks to your project's grunt implementation, you may define
them directly in your Gruntfile.js or include them from separate files.

## Load a plugin managed by npm

```js
grunt.loadNpmTasks('grunt-plugin-name');
```

### Load a local grunt plugin

```js
grunt.loadTasks(__dirname + '/grunt/tasks');
```

## Overriding existing tasks

To override an existing task the trick is to add code that will be the final
piece to adjust the configuration of the task. This may be a specific
configuration element, or a redefinition of the entire task.

### Override a task's configuration

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

## Re-register the validate task

In your project's `Gruntfile.js`, use the `grunt.registerTask()` function to
override task aliases, like default, validate, and analyze.

The following example changes the list of tasks run by the `validate` command:

```js
var taskList = ['phpcs:full'];
grunt.registerTask('validate', taskList);
```

## Customizing Help Output (Help API)

If you add custom tasks to your project and want them exposed as part of the
`help` task, you may add a simple code snippet to your Gruntfile.js or any
loaded task file.

```js
var Help = require('grunt-drupal-tasks/lib/help');

Help.addItem('existing-task', 'Named Group', 'Optional description that avoids the default task description.');

Help.add({
  task: 'existing-task',
  group: 'Named Group',
  description: 'Optional description that avoids the default task description.'
});

Help.add([
  {
    task: 'existing-task',
    group: 'Named Group',
    description: 'Optional description that avoids the default task description.'
  },
  {
    task: 'second-task',
    group: 'Named Group',
    description: 'A second registered task to register with the help system.'
  }
]);
```

If you want to include your task in one of the existing groups, copy the text
exactly as seen in the output of the `grunt help` task.

## Leveraging Bash Scripts

If you have an existing project or a kit of useful project utilities, you may
have some Bash scripts laying around that you want to keep. Sometimes Bash
or PHP are simply better for managing a Drupal system, other times you want to
keep the up-front time of integrating the Grunt tools minimal.

The preferred approach is to configure your scripts via the **Project
Operations** system. This allows you to run your script via
`grunt custom-install`, and pass any grunt-derived configuration you might need
to the script.

If you want to automatically load your scripts, here is a script based on
[grunt-shell](https://github.com/sindresorhus/grunt-shell) you can use.

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
