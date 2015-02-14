# CHANGELOG

## v0.5.2 [2015/01/24]

- Adding configuration for the Drush executable path, whether to trigger a fail
for PHPCS warnings, and help text for custom tasks
- Including dot files in `package` task results
- Pinning npm dependencies to a specific version for stability
- Adding tests for Compass theme compilation (and implicitly Bundler dependency
installation)

### Upgrade Notes

- The example project's configuration will install a copy of Drush in the
project's `bin/` directory, and use this copy for all Drush operations. To
adopt this practice on existing projects, add the Drush dependency to your
project's `composer.json` and specify the path in Gruntconfig.json with:

```json
  "drush": {
    "cmd": "bin/drush"
  }
```

## v0.5.1 [2015/01/10]

- Critical bug fixes to Bundler and Drush support
- Adding a script to support the `npm test` command for running an end-to-end
test on Grunt Drupal Tasks functionality similar to the Travis CI script

### Upgrade Notes

- Update your project's package.json to require at least v0.5.1 of Grunt Drupal
Tasks by using the `~0.5.1` version field value.

## v0.5.0 [2015/01/05]

- Moving main Grunt Drupal Tasks library code from Gruntfile.js to bootstrap.js
- Adding integration with OS notification features with grunt-notify
- Adding documentation for use with a continuous integration system
- Wrapping `behat` task in a `test` alias and moving Behat-related files into
- top-level `test/` directory to allow for multiple testing methods
- Adding Zombie.js and Behat support for JavaScript testing
- Replacing grunt-parallel with grunt-concurrent
- Many dependency updates
- Other minor improvements

### Upgrade Notes

- Change your project's Gruntfile.js to include grunt-drupal-tasks using
`require('grunt-drupal-tasks')(grunt);` instead of 
`require('grunt-drupal-tasks/Gruntfile')(grunt);`

- By default, Behat expects test features and the behat.yml inside a top-level
`test/` directory. You can either update your project structure by moving
behat.yml and the features directory under `test/`, or you may continue to use
the old structure by providing a `config` and `src` option for any configured
sites. For example:

```json
  "behat": {
    "default": {
      "config": "./behat.yml",
      "src": "./features/**/*.feature"
    }
  }
```

- Custom tasks that execute steps in parallel should be updated to use the
grunt-concurrent plugin. See grunt-drupal-tasks/tasks/behat.js for an example.

- See the example composer.json for updated dependency versions, which you can
manually apply to your project.
