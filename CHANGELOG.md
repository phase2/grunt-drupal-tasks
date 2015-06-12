# CHANGELOG

## Next [2015/??/??]

### New Features

- Added `grunt serve` task to [easily install and run the Drupal site](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#serve-settings) without external dependencies like Apache.
- Added theme scripts system to allow themes to own their [CLI destiny](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#theme-scripts).
- Added `phplint.dir` setting to Gruntconfig to allow customization of linting paths.
- Added validate:newer and switched watch configuration top-level use it. Speed increase!
- [New settings for `grunt package`](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#package-settings)
to make it easier to configure Acquia or Pantheon-compatible packages. Now
produces a clean directory package for easy commit as-is to a release repository.

### Building GDT

- Added Drupal 8 test coverage, Travis and `npm test` will now run tests against D7 and D8.
- Added support for actions against configured URLs for multiple environments. (#32, #41, [documentation (domain & siteUrls)](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#core-settings))
- Additional unit & integration tests. (So far we've only been running end-to-end tests.)

### Breaking Changes

- Renamed GRUNT_DRUPAL_QUIET to GDT_QUIET
- `grunt package` no longer compresses by default. Use `grunt package:compress` to replicate existing behavior.

## v0.6.1 [2015/05/17]

- Adding documentation on Gadget, the Yeoman generator for Grunt Drupal Tasks.
- Ensuring dot-files are copied from the temporary build (Drush output) and the
static files directory.
- Adding --notify option as a converse of --quiet.
- Adding .editorconfig to the project example.

## v0.6.0 [2015/04/07]

- **Added automatic support for Drupal 8 based on Drush detection of the Drupal
  version.**
- Dynamically compute Drush Make concurrency based on system capability with a
  new concurrency detection service.
- Ruby (bundler) will now install dependencies into `vendor/bundle`.
- Ruby and PHP upstream binaries are placed or symlinked from `vendor/bin`.
  This frees up `bin/` for custom project scripts.
- Adding default values for the buildPaths in the project Gruntconfig.json so
  the buildPaths config is no longer required.
- Ensure reports directory is created before running analyze.
- Support for \*.sass files in compass watch.
- Refactored `grunt help` task to be extensible from separate projects.
- The docroot assembly tasks (such as the symlinking) performed after drush make
  have been consolidated into a new `scaffold` task.
- Due to npm's behavior that strips .gitignore files from packages, the example
  .gitignore is renamed to gitignore, and needs to be renamed manually after
  installation.

### Upgrade Notes

- Remove the Drush Make `--concurrency` option from your Gruntconfig. It will no
  longer be respected.
- The example `composer.json` and `Gruntconfig.json` have been both updated
  to support installing PHP component executables to `vendor/bin` instead
  of `bin`. If you want to continue using `bin`, use caution when updating
  these files.
- Ruby bundle executables are moved to `vendor/bin` from `bin`. This change is
  intrinsic to v0.6.0. You may need to run `rm -Rf .bundle` to clear Bundler
  configuration to make way for the new install location.
- Gruntconfig.json no longer needs the `buildPaths` config key. Elements of
  `buildPaths` added to your project Gruntconfig will override default behavior.
- Configuration of `grunt help` for project-specific tasks via Gruntconfig.json
  removed in favor of new [Help API](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#help-settings-help-api).

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
