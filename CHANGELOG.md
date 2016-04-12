# CHANGELOG

## v1.0.0-pre

- Dropped support for Node.js v0.12 and earlier and PHP v5.4 and earlier.
- Removed built-in support for Compass theme compilation and Ruby bundle
installation.
- Updated dependencies.

### Upgrade Notes

- Node.js v4 or later is required. Grunt Drupal Tasks is now compatible with
Node.js v5.
- PHP v5.5 or later is required.
- Use of the built-in Compass theme compilation steps must be replaced by custom
handling at the project- or theme-level.

## v0.11.0 [2016/04/12]

- Updated example to use Grunt v1.x. Resolved peer dependency compatibility
issues with dependencies.
- Adding default options to use with `composer install` to improve performance
and cacheability.
- Added support for processing `*.make.yml` as Drush make files.
- Fixed issue on Windows where copy:tempbuild was never called.
- Updated dependencies in example project and for the plugin itself.

### Upgrade Notes

- Grunt should be a dependency in the `package.json` file of projects that use
Grunt Drupal Tasks. It is recommended to update this to use Grunt `^1.0.0`. If
projects include any dependency that specifies Grunt as a peer dependency and is
limited to version `< 0.5`, then you may encounter an incompatible peer
dependency error when running `npm install`. The recommended solution is to
upgrade dependencies to versions that are compatible with Grunt v1.x.

## v0.10.1 [2016/03/17]

- Using Drush --root option by default to ensure the docroot is identified.
- Updating example project to install Drush 8.x instead of dev-master.
- Removing the theme validate step from the validate:staged special command,
due to incompatibilities.

## v0.10.0 [2016/03/08]

- Replaced copy with rsync to move the temporary build output as part of the
default build process. For Windows environments, copy is still used.
- Added support for running tests included with custom modules for Drupal 8.
- Updated default phplint patterns to skip `*.panels_default.inc` files.
- Removed peer dependency on Grunt in package.json. This prevents issues when
updating to the forthcoming Grunt 1.0.0.
- Updating Node.js engines requirement in package.json to v0.12.0 or later.
- Updated dependencies.

### Upgrade Notes

- Node.js v0.10.x is no longer supported.
- Project configurations that override the default `drushmake` task should be
updated to use `rsync:tempbuild` instead of `copy:tempbuild` on non-Windows
environments. The `canRsync` function from `lib/util.js` should be used to
determine if rsync is supported in an environment.

## v0.9.3 [2016/02/25]

- Improved performance for code style quality checks by limiting file scans.
- Updated default file patterns for code style quality checks.
- Added Travis CI test coverage for more versions of Node.js.
- Fixed Drupal 8 tests by adding a D8-specific composer.json file.

## v0.9.2 [2016/01/27]

- Added `--no-validate` command line option to skip running the `grunt:validate`
tasks, including PHPCS and eslint.
- Fixed bug that prevented phpcs and eslint from running
- Fixed bug that caused scope error for this.name.
- Updated dependencies. Added npm shrinkwrap file to ensure consistency between
installations.

## v0.9.1 [2015/12/10]

- Add config option to specify command runner in git hook scripts.
- Fixed Gruntconfig.json interpretation for disabling tasks and specifying port
for the serve task.
- Fixed error when using a theme's validate script.
- Configured copy operations during build to ensure file modes are preserved.

## v0.9.0 [2015/11/18]

- Added the ability to [define scripts for common project operations](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#project-operations).
- Added `grunt install` task to [easily install the site cleanly or with an
imported database](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#install-settings).
- Added optional [integration with Git Hooks](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#adding-git-hooks)
to support running Grunt tasks when git operations are run. When enabled, the
validation task is run against staged code before a commit is made.
- If index.php is missing from the build destination, then the Drush make task
is always run (and the "newer" feature is disabled). This facilitates certain VM
configurations.
- PHPCS and eslint tasks are skipped if there are no source files.

### Upgrade Notes

- Themes with a validate task configured are excluded by default from the Grunt
Drupal Tasks validate task.

## v0.8.0 [2015/07/24]

- Fixed bug in theme proxying feature.
- Updated Travis CI test configuration to use improved infrastructure and test
additional PHP versions.
- Added default scaffold task to symlink any directories in `src/libraries` to
`build/html/sites/all/libraries` (for D7) or `build/html/libraries` (for D8).

## v0.7.1 [2015/06/24]

- Fixing error with 'grunt serve' due to drush:serve not being defined.
- Ensuring that Behat is run with the Grunt process's environment variables.

## v0.7.0 [2015/06/16]

### New Features

- Added eslint JavaScript code quality checking to the validate and analyze
tasks.
- Added `grunt serve` task to [easily install and run the Drupal site](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#serve-settings)
without external dependencies like Apache.
- Added theme scripts system to allow running [theme-provided build scripts](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#theme-scripts)
as part of the GDT build process.
- Added `phplint.dir` setting to Gruntconfig to allow customization of linting
paths.
- Added `grunt validate:newer` to validate only files changed since the last
run, and using it for the `grunt watch` task for a speed increase!
- [New settings for `grunt package`](https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#package-settings)
to prepare output ready for commit to Acquia- and Pantheon-style release
repositories.
- Added Drupal 8 test coverage, Travis and `npm test` will now run tests
against D7 and D8.
- Added support for actions against configured URLs for multiple environments.
See documentation for more information: https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md#core-settings
- Additional unit & integration tests.

### Upgrade Notes

- The GRUNT_DRUPAL_QUIET environment variable to enable quiet mode is renamed
to GDT_QUIET.
- `grunt package` no longer compresses by default. Use `grunt package:compress`
to replicate former behavior.

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
