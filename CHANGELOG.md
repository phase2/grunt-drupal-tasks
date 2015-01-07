# CHANGELOG

## v0.5.0

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
