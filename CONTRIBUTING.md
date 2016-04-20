## Contributing

If you would like to contribute to this project, here are a few considerations.

### Adding a New Task

Adding a new task should only be done if a majority of projects should use that
functionality. Really cool tasks that seem useful for less than 80% of Drupal
projects using this system should be a separate project. Different projects can
still follow the philosophy of Grunt Drupal Tasks and will happily be linked
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
  tasks should take that into account.

- The tasks in the main build process should provide command-line results for
  ease of developer troubleshooting.

- Changes to the directory structure or subtractions/renames in the supported
  Grunt configuration are considered backwards compatibility breaks.
