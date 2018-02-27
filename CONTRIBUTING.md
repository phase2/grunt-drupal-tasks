# Contributing

If you would like to contribute to this project, here are a few considerations.

## Change Guidance

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

## Testing & Validation

Run `npm test` to confirm your changes will not break the tests. It is okay if you
expect the tests to pass to rely on Travis to fail your build, but if it does fail
please avoid using Travis to explore passing solutions.

## Using Work-in-Progress on a Live Project

1. Create your project environment with [generator-gadget](https://github.com/phase2/generator-gadget)
2. Temporarily remove grunt-drupal-tasks from package.json to avoid unnecessarily installing it.
3. Run `npm install` for your project if you haven't yet and any npm dependencies remain.
4. Navigate to your node_modules directory, and create a symlink to your working directory: `ln -s ~/Projects/grunt-drupal-tasks .`

## Docker-based Development

* **Running Tests**: `docker-compose run --rm test`
* **Live Project**: Replace step 1 with [generator-outrigger-drupal](https://github.com/phase2/generator-outrigger-drupal),
preferably via `rig project create`. Replace step 4 by one of the options below:

### Copy/Move Your Working Repo

You may simply move your cloned grunt-drupal-tasks repo inside the node_modules
directory of the project so it is synced into the container.

### Temporary Volume Mount

In all containers which need access to grunt-drupal-tasks, add a volume mount
to override the grunt-drupal-tasks directory structure with your working copy.
In docker-compose.yml terms, that might look like the following:

```yaml
- ~/Projects/grunt-drupal-tasks:/var/www/node_modules/grunt-drupal-tasks:ro
```

This uses the read-only flag to ensure any build actions do not overwrite your
working code.
