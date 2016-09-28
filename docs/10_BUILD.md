# Code Structure & Build Process

> What's your codebase and how is it used in a working Drupal site?

Continuing discussing of code structure begun in the [Setup section](05_SETUP.md),
Grunt Drupal Tasks is a build system driven by a known "scaffolding" configuration to assemble a working Drupal site from custom code and
dependency manifests.

## The Build

```
$> grunt
```

The build process is managed by running `grunt`. If there are no errors, this will result in assembling all the code and assets needed to run your Drupal site in **build/html**. The full process includes a number of steps, which assumes the checkout of the codebase has already run `npm install` to retrieve all Node dependencies.

1. **Composer Install:** Retrieve all development dependencies in the project
  composer.json. (Note that this does not imply management of Drupal dependencies
  via Composer, such functionality is on the roadmap).
2. **Validate:** Run static analysis and code quality checks against custom code.
3. **Drush Make:** If the Drush makefiles are newer than the built codebase, will
  run Drush Make to assemble upstream dependencies. (A composer-based alternative
  is on the roadmap.)
4. **Scaffold:** Copy and symlink custom code into the assembled codebase.
5. **Theme Triggers:** Run any theme triggers to validate code or build assets
  on a per-theme basis.

## The Scaffold

The scaffold, which can be thought of as the root directory and the conventions
around having discrete `src/`, `build/`, `test/`, and other folders, focuses on
providing clear context to developers for the different pieces of the codebase.

Operational code and build artifacts are contained in the `build/` directory,
the other parts of the repository are intuitively discovered for easy editing.

Examples in the documentation and the default behavior of Grunt Drupal Tasks,
use a standardized convention that is significantly configurable for individual
project needs.

### Structure of the Code Repository

On looking at the code repository, there is no sign of Drupal core. That is because Drupal core, contributed modules, and any other upstream dependency or generated code is not part of the code repository. This structure organizes custom code, configuration, and manifests of dependencies which are downloaded as-needed by the *build process*.

```
src/
  ↳ libraries/
  ↳ modules/
  ↳ profiles/
  ↳ sites/
  ↳ static/
  ↳ themes/
  ↳ project.make
test/
  ↳ behat.yml
  ↳ features/
composer.json
Gruntconfig.json
Gruntfile.js
package.json
phpmd.xml
```

### Setting up Source Code

- Place custom modules in **src/modules/**. When the project is built, the
  contents of src/modules/ become part of the Drupal's sites/all/modules/
  directory (via a symlink from sites/all/modules/custom/ to src/modules/).

- Place custom installation profiles in **src/profiles/**. When the project is
  built, the contents of src/profiles become part of Drupal's sites/all/modules/
  directory (via symlink from profiles/ to each profile in src/profiles/).

- Customize the Drush make file that is used at the start of the build process.
  The example includes **project.make** but this file can be replaced or renamed
  with a setting change in Gruntconfig.json (see below).

- Include any sites directories (like "default"), optionally with settings.php
  or other files, and if needed a multi-site sites.php in **src/sites/**. (The
  contents of src/sites/ are copied into sites/.)

- Include any static files that should be copied into the Drupal docroot on
  build in **src/static/**. This allows for overriding files like `.htaccess`.

- Place custom themes in **src/themes/**. When the project is built, the
  contents of src/themes/ become part of the Drupal's sites/all/themes/
  directory (via a symlink from sites/all/themes/custom/ to src/themes/).

### Build Directory Structure

```
build/
  ↳ cache
  ↳ html
  ↳ packages
  ↳ reports
  ↳ temp
node_modules/
vendor/
```

## Customizing the Build

Grunt Drupal Tasks is designed to provide sensible default behaviors for Drupal
projects, but allow these assumptions to be overridden.

**Gruntconfig.json** is a settings file that allows certain paths and optional
features to be configured on a project-specific basis.

### Configuration Options

The core set of configuration options for Gruntconfig.json specify the basic
build parameters: the code to build, and the output directories to use.

This is the minimum set of configuration options:

```
{
  "srcPaths": {
    "drupal": "src",
    "make": "src/project.make"
  }
}
```

**srcPaths.drupal**: The directory that contains all project-specific Drupal
code and configuration. Grunt Drupal Tasks assumes this directory has the
following structure:

```
src/
  modules/
  profiles/
  sites/
  static/
  themes/
```

**srcPaths.make**: The Drush make file used to assemble the Drupal project.

The following build output paths are optional to specify in the project's
`Gruntconfig.json` file.

**buildPaths.build**: The directory that should be used for miscellaneous build
artifacts. This can be the parent directory of the following build paths.

**buildPaths.html**: The directory that should be used for the Drupal docroot
build destination generated by the default build operation.

**buildPaths.package**: The directory that should be used to store packages
generated on demand by the *package* operation.

**buildPaths.reports**: The directory that should be used for output from the
analysis and validation tools.

**buildPaths.temp**: The directory that should be used for temporary build
artifacts. This can be a subdirectory of `buildPaths.html`.

### Developer Modification

There are two ways to change the default build process (which is run when simply
typing `grunt` into the command-line.)

### Fork the Build Process
Add the following code snippet after the Grunt Drupal Tasks `bootstrap.js` file
is loaded in your `gruntfile.js`.

```
grunt.registerTask('default', [
  'alternate',
  'list',
  'of',
  'tasks'
]);
```

You may use any of the tasks available to Grunt when doing this, though
significant changes to the build process may make it difficult to get support.

### Prepend or Append New Tasks

If you want to avoid forking the build process, but have some additional tasks
that need to be done, you can use this trick to add new tasks to the build.

This trick can be done multiple times after the initial load of `boostrap.js`,
which allows for modular customizations.

```js
grunt.task.renameTask('default', 'default-pre-custom');
grunt.registerTask('default', ['shell:custom', 'default-pre-custom']);
```

### Hacking Drush Make

### Drush Settings

This is an example of the settings for Drush tasks:

```
{
  "drush": {
    "cmd": "/usr/bin/drush",
    "make": {
      "args": ["--force-complete", "--working-copy"]
    }
  }
}
```

**drush.cmd**: The path to the Drush executable that should be used for all
Drush operations. If none is specified, the Drush executable found in the
default PATH will be used.

**drush.make.args**: An array of arguments to pass to Drush for the make
operation.
