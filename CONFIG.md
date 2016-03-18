# Set Up Your Drupal Project

This is a guide for integrating Grunt Drupal Tasks with your Drupal project.

## Start using Gadget

The easiest way to start a new Drupal project with Grunt Drupal Tasks is to use
*Gadget*, a tool which offers an interactive, text-based approach to building
an initial project template.

Once you have Gadget installed, start a new Drupal project by running `yo
gadget` in an empty directory.

For information on installing Gadget and other options, see:
https://github.com/phase2/generator-gadget

## Start with the example

This repository includes an example that you can use as an initial scaffold for
your Drupal project. To find this template, you can use the following commands:

1. In an empty directory, run:
   `npm install grunt-drupal-tasks`

2. Copy the contents of node_modules/grunt-drupal-tasks/example to your starting
   directory, by running:
   `cp -rf node_modules/grunt-drupal-tasks/example/* .`

3. Rename the file `gitignore` to `.gitignore`, by running:
   `mv gitignore .gitignore`

The directory's contents should now look like this:

```
Gruntconfig.json
Gruntfile.js
composer.json
node_modules/
  ...
package.json
phpmd.xml
src/
  modules/
  profiles/
  project.make
  sites/
  static/
  themes/
test/
  behat.yml
  features/
```

## Add project code and configuration

After setting up the project directory, the next step is to configure the Drush
make file and add your custom code and configuration in the directories under
**src/**.

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
  build in **src/static/**. This allows for overriding files like .htaccess.

- Place custom themes in **src/themes/**. When the project is built, the
  contents of src/themes/ become part of the Drupal's sites/all/themes/
  directory (via a symlink from sites/all/themes/custom/ to src/themes/).

At this point, you should be able to run `grunt` to build a Drupal site into
**build/html/** using the make file and adding any custom modules, themes, and
other files included in src/ directories.

## Use other features

The example template bundles a **composer.json** file that installs supporting
tools, like Behat with the Drupal Extension, PHPMD (PHP Mess Detector), and the
PHP Code Sniffer, among others. By default, the build runs "composer install" to
install these tools. You can modify composer.json to include other dependencies
for your project.

To support Behat tests, the example includes a basic **behat.yml** configuration
file and a **features/** directory for test cases inside the general **test/**
directory.

The example also includes **phpmd.xml** to provide some sensible defaults for
Drupal development to the PHPMD utility.

## Customize the tasks

Grunt Drupal Tasks is designed to provide sensible default behaviors for Drupal
projects, but allow these assumptions to be overridden. There are three ways to
customize the build and testing tasks:

- **Gruntconfig.json** is a settings file that allows certain paths and optional
  features to be configured on a project-specific basis. See the next section
  for more information on the settings in Gruntconfig.json.

- Many core tasks, like the default build task or the analyze and validate
  tasks, define a series of sub-tasks to run. The sequence of sub-tasks can be
  modified in the project's **Gruntfile.js**. See EXTEND.md.

- In some cases, you may need to add new tasks or alter existing tasks for your
  project. See EXTEND.md.

## Modify Gruntconfig.json

The following sections document all configuration options that can be set in the
project-specific Gruntconfig.json file.

### Core Settings

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

**srcPaths.make**: The Drush make file used to assumble the Drupal project.

The following build output paths are optional to specify in the project's
Gruntconfig.json file.

**buildPaths.build**: The directory that should be used for miscellaneous build
artifacts. This can be the parent directory of the following build paths.

**buildPaths.html**: The directory that should be used for the Drupal docroot
build destination generated by the default build operation.

**buildPaths.package**: The directory that should be used to store packages
generated on demand by the *package* operation.

**buildPaths.reports**: The directory that should be used for output from the
analysis and validation tools.

**buildPaths.temp**: The directory that should be used for temporary build
artifacts. This can be a subdirectory of buildPaths.html.

**domain**: The domain of the site without protocol. It may also be a Base URL
(with a path prefix) so long as the protocol is excluded. This domain is used
to construct complete URLs for testing purposes. This may be overridden by the
`GDT_DOMAIN` environment variable, and if neither is set will fall back to the
environment's hostname. If a domain is specified, we recommend it is lined up
with any standard set for local development, as development processes should
not default to hitting a production or staging environment.

**siteUrls**: (Optional) A map of Drupal subsite names to the URLs by which
each can be accessed for end-to-end testing by tools such as Behat. For clarity
please align the site names (keys) with any Drush Site Aliases. If no siteUrls
are specified it will default to `http://<%= config.domain %>`. The environment
variable override is `GDT_SITEURLS`.

```
  "siteUrls": {
    "default": "http://<%= config.domain %>",
    "subsite": "http://sub.<%= config.domain %>.local",
    "external": "http://example.com"
  },
```

### Analyze Settings

This is an example of the settings for analyze tasks:

```
{
  "phpmd": {
    "configPath": "phpmd.xml",
    "path": "bin/phpmd"
  }
}
```

**phpmd.configPath**: The configuration file to use with PHPMD. Defaults to
*phpmd.xml*.

**phpmd.path**: The path to the PHPMD executable.

> If there is no `phpmd` key in the configuration, the system will assume you
are not using PHPMD and will suppress it from the system.

### Behat Settings

This is an example of the settings for Behat tasks:

```
{
  "behat": {
    "flags": "--tags '~@javascript'",
    "subsite": {
      "src": "./test/features/subsite/*.feature",
      "debug": false
    }
  }
}
```

**behat.\<siteurl\>**: A map of Drupal subsite names to a configuration object,
which will extend the defaults passed to
[grunt-parallel-behat](https://github.com/linusnorton/grunt-parallel-behat)

**behat.flags**: A string with any command-line arguments and options that
should be used while invoking Behat. These flags can be overridden by using the
`--behat-flags` option when running `grunt`. Common use cases are to include or
exclude tests according to tags or to use an alternative profile defined in
`behat.yml`.

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

### Notify Settings

This is an example of the settings for the notify feature:

```
{
  "notify": {
    "threshold": 3
  }
}
```

**notify.threshold**: Minimum number of seconds a task must execute for a
notification to be triggered when the task ends.

### Theme Settings

This is an example of the settings for theme tasks:

```
{
  "themes": {
    "spartan": {
      "path": "<%= config.srcPaths.drupal %>/themes/spartan"
    }
  }
}
```

**themes**: Defines each custom Drupal theme and enables features, like
integration with theme scripts.

**themes.\<theme\>.path**: Specify the path to the theme. Defaults to
`<%= config.srcPaths.drupal %>/themes/\<theme\>`.

#### Theme Scripts

Many themes come with their own tooling, possibly grunt-based as well. In those
cases you can configure Grunt-Drupal-Tasks with the ability to trigger those
tasks, and by magic naming attach some theme-specific functions to the more
general project tasks.

```
"legionaire": {
  "path": "<%= config.srcPaths.drupal %>/themes/legionaire",
  "scripts": {
    "compile-theme": "grunt compile"
    "validate": "grunt eslint",
    "analyze": "echo 'No theme-specific analysis tools here!'",
    "ls": "ls -lR"
  }
}
```

`grunt themes` may be run to list all themes setup in your project
Gruntconfig.json. `grunt themes:\<theme\>` will list all the options in the
theme's scripts config as a means of providing usage documentation.
`grunt themes:\<theme\>:\<task\>` will run the script keyed by `\<task\>` from
the theme's directory.

Three of the key names are magic: 'compile-theme', 'validate', and 'analyze'.
When one of those three is specified, Grunt Drupal Tasks will automatically
run the command as part of the actions it takes for `grunt compile-theme`,
`grunt validate`, and `grunt analyze`.

Note that Theme Scripts support the `pre-` and `post-` operations explained in
Project Operations.

### Validate Settings

This is an example of the settings for the validate tasks:

```
{
  "eslint": {
    "dir": [
      '<%= config.srcPaths.drupal %>/themes/*/js/**/*.js',
      '<%= config.srcPaths.drupal %>/{modules,profiles,libraries}/**/*.js'
    ]
  },
  "phpcs": {
    "path": "bin/phpcs",
    "standard": "vendor/drupal/coder/coder_sniffer/Drupal"
  }
  "phplint": {
    "dir": [
      '<%= config.srcPaths.drupal %>/sites/**/*.{php,inc}',
      '<%= config.srcPaths.drupal %>/themes/*/template.php',
      '<%= config.srcPaths.drupal %>/themes/*/templates/**/*.php',
      '<%= config.srcPaths.drupal %>/themes/*/includes/**/*.{inc,php}',
      '<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/*.{php,module,inc,install,profile}',
      '!<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/*.{box,pages_default,views_default,panelizer,strongarm}.inc',
      '!<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/*.features.*inc',
      '!<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/vendor/**'
    ]
  }
}
```

> If there is no `phpcs` key in the configuration, the system will assume you
are not using PHPCS and will suppress it from the system.

**eslint**: To enable eslint, set to `true` to use default options or an object
with the following optional settings.

**eslint.configFile**: The path to the eslint config file to use. If no value
is specified, then `.eslintrc` in the project root is used.

**eslint.dir**: An array of glob patterns to include/exclude files for
review by eslint. The following is used by default:

```
{
  "eslint": {
    "dir": [
      '<%= config.srcPaths.drupal %>/themes/*/js/**/*.js',
      '<%= config.srcPaths.drupal %>/{modules,profiles,libraries}/**/*.js'
    ]
  }
}
```

**phpcs.path**: The path to the PHPCS executable.

**phpcs.standard**: The PHPCS coding standard to use. The example composer.json
installs the Drupal Coder's standard, the path of which is shown above.

**phpcs.dir**: An array of globbing pattern where phpcs should search for files.
This can be used to replace the defaults supplied by grunt-drupal-tasks.

This example placed in the Gruntconfig.json file ignores directories named
"pattern-lab" and a "bower_components" in addition to the defaults that come
with grunt-drupal-tasks:

```
{
  "phpcs": {
    "path": "vendor/bin/phpcs",
    "dir": [
      '<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/*.{php,module,inc,install,profile}',
      '!<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/*.{box,pages_default,views_default,panelizer,strongarm}.inc',
      '!<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/*.features.*inc',
      '!<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/vendor/**',
      '!<%= config.srcPaths.drupal %>/{modules,profiles,libraries,static}/**/*.tpl.php'
    ]
  }
}
```

**phplint.dir**: An array of globbing patterns which phplint should include or
exclude from PHP code syntax validation.

**validate.ignoreError**: Set to `true` to prevent failing the build if code
quality validation fails (which also prevents other tasks from executing).

### Package Settings

The `grunt package` task allows you to assemble and independently exported
Drupal codebase. This is used to facilitate deployment of the minimal code
needed to run Drupal in a formal environment such as Production.

You can find the resulting package in `build/packages/package` by default as a
standard directory, all symlinks from the grunt scaffolding dereferenced. If
run with `grunt package:compress` it will also output
`build/packages/package.tgz` as an easily stored archive. **Remember, this
directory is wiped by `grunt clean` unless you configure your package directory
to be outside the build directory.**

This is an example of the settings for package tasks:

```
{
  "packages": {
    "srcFiles": ["!sites/*/files/**", "!xmlrpc.php", "!modules/php/*"],
    "projFiles": ["README*", "bin/**"]
  }
}
```

**packages.srcFiles**: An array of files or file patterns to include or exclude
from the build output when building a package. The above excludes files within
any sites/*/files directory, and Drupal's xmlrpc.php and PHP Filter. For more on
this format, see: http://gruntjs.com/configuring-tasks#files

**packages.projFiles**: An array of files or file patterns to include or exclude
from the project directory when building a package. The above includes README
files and files under bin/ in the project's package.

**packages.dest.docroot**: Specify where within the package directory the
`srcFiles` should be placed. Defaults to the package root. For Acquia set this
to '/docroot'.

**packages.dest.devResources**: Specify where within the package directory the
`projFiles` should be placed. Defaults to package root.

### Project Operations

Some of the most common use cases for any Drupal site are the basic operations
of installation, running database updates, and clearing the cache. These are not
difficult operations, but many developers appreciate the common shorthand a
little grunt magic can provide.

To keep this flexible the new Operations system offers nothing out of the box,
but facilitates creating lightweight commands or callouts to the shell for more
advanced scripts you want easily run on the project by the entire team.

This should remind you of the **Themes Scripts** described above.

```
{
  "scripts": {
    "update": "drush <%= config.alias %> updatedb -yv && drush <%= config.alias %> features-revert-all -yv",
    "reset": "drush <%= config.alias %> registry-rebuild && drush <%= config.alias %> cc all"
  }
}
```

Here you see two commands defined inside the top-level `scripts` configuration.

* `grunt update` demonstrates running database updates and reverting all
[Features](http://www.drupal.org/project/features).
* `grunt reset` demonstrates a thorough reset of the file registry and Drupal
caches.

The Alias and Profile is specified per the rules for **Magic Configuration**.

**alias**: The Drush Site Alias. This is computed as a helper for use in
project operations, but is not yet applied as part of other tasks. Defaults to
`@<domain>`. The environment variable to override is `GDT_SITE_ALIAS`.

#### Pre and Post Operations

Similar to `npm run`, the operations defined in your Gruntconfig will support
`pre-` and `post-` variants. If the main script exists the pre-script will be
triggered first and the post-script will be triggered after. This allows you to
easily extend any project operation with separate grunt, bash, or other tasks.

### Install settings

The `install` task will either install Drupal via the configured `profile`, or
if a path to a database is configured, load this database:

To specify a profile other than the `standard` profile:

```json
{
  "project": {
    "profile": "openatrium"
  }
}
```

to specify a database to load:

```json
{
  "project": {
    "db": "path/to/project.sql.gz"
  }
}
```

**project.profile** The Drupal installation profile, this will be used to
configure the behavior of the `grunt install` and `grunt serve` tasks. Defaults
to `standard`. The environment variable is `GDT_INSTALL_PROFILE`

**project.db** If specified, this database will be loaded instead of running a
site installation. If the file referenced is not present `grunt install` will
fall back to a standard `drush site-install`.

#### Pre and Post Installation

The install task has a unique implementation of support for the pre and post
scripts otherwise made available for themes and project operations. This allows
you to implement simple directives or scripts to prepare for installation or
perform non-standardized operations after the main installation routine.

### Serve Settings

The Serve task allows you to run Drupal using PHP's built-in webserver. This
facilitates quick demos and low-overhead development for projects with simple
infrastructure requirements. When using this task it will take over the
terminal window.

`grunt serve` will not install the Drupal site. Run with `grunt serve:demo` to
skip starting up watch tasks.

```json
{
  "project": {
    "profile": 'project_profile_name'
  },
  "serve": {
    "port": 9043,
    "concurrent": [
      "watch-theme"
    ]
  }
}
```

**serve.profile**: DEPRECATED - use **project.profile** instead.

**serve.port**: The port number to bind for the webserver. Only one service may
occupy a port on a machine, so a project-specific port may be worthwhile.
Defaults to `8080`.

**serve.concurrent**: An array of grunt tasks to be run concurrently to the
server. When run with `serve:demo` or `serve:test` these tasks are not used. By
default they include 'watch-test' and 'watch-theme'. If you use this
configuration to add tasks be sure to include these as they will be suppressed
by any configuration.

### Magic Configuration

The domain, project.profile, alias, and siteUrls configurations are all built
using the same system that allows for maximum flexibility in project and
environment configuration. Note that all configuration is subject to the Project
Gruntfile override.

In order of precedence it checks the following:

#### Priority 1: Project Gruntfile.js

The value of the configuration prefixed with `gdt.`. This allows a project
Gruntfile to dynamically specify the value before bootstrapping Grunt Drupal
Tasks. This is valuable because the code of grunt-drupal-tasks sets up many
behaviors based on that configuration that would be difficult to replicate
after the bootstrap.

This can be done with any configuration you might place into your
Gruntconfig.json, and is merged recursively as an override to whatever you place
in that file.

For example:

  * **alias**: `gdt.alias`
  * **domain**: `gdt.domain`
  * **profile**: `gdt.profile`
  * **siteUrls**: `gdt.siteUrls`

Suppose your environment is set up with the following directory structure:

>  * project.example.com
    * project-repository
      * Gruntfile.js
      * Gruntconfig.json
      * src/
      * ...
   * project2.example.net
     * ...

Given this structure, you will not want to use environment variables because
each of your projects might need different values in the host machine. However,
a little logic in the project Gruntfile.js can allow you to dynamically derive
your development domain or Drush site alias.

For example, here is a Gruntfile that derives the site alias and domain
based on the parent directory name of the project repository.

```js
var path = require('path');
module.exports = function(grunt) {
  var name = path.basename(path.resolve(__dirname, '..'));
  // Set domain to "project.example.com". If nothing else sets the `alias`
  // it will default to @project.example.com.
  grunt.initConfig({ gdt: { domain: name });
  // Load all plugins and tasks defined by the grunt-drupal-tasks package.
  require('grunt-drupal-tasks')(grunt);
};
```

#### Priority 2: Environment Variable

Each magic configuration property can also be set via an Environment Variable.

Environment Variables are extremely powerful, but only useful where the
environment contains only a single project using Grunt Drupal Tasks. This is
more effective for dedicated environments, such as official production and
staging servers, or virtual and containerized environments.

The specific environment variable name is covered as part of the property
descriptions.

#### Priority 3: Project Gruntconfig.json

The configuration placed in Gruntconfig.json. This is good for straightforward
defaults and is how all *non-magical* configuration works.

If you want to include your task in one of the existing groups, copy the text
exactly as seen in the output of the `grunt help` task.

### Adding Git Hooks

The [Git Hook system](http://git-scm.com/docs/githooks) (not to be confused with
the Drupal Hook system), triggers events on certain git interactions. The git
**pre-commit** hook allows us to add a validation step to the commit process
that will block developer's from committing work if it does not get approved by
a script.

Git hook scripts need to be manually installed on a per-repository basis, so
Grunt Drupal Tasks facilitates by allowing easy configuration of the
grunt-githooks plugin as part of our `grunt git-setup` task.

#### Default Task

By default, Grunt Drupal Tasks installs a special variant of the `validate`
task. This version, specifically invoked by `validate:staged` attempts to
minimize the number of files scanned by checking only those that have changed
since the last successful commit.

#### Configuring Git Hooks

**config.git.hooks**: An array of grunt tasks to run on pre-commit in addition to `validate:staged`.

**config.git.hook-command**: A substitute for a simple `grunt` command to handle the individual grunt tasks.
Allows specification of more complex bin paths or execution wrappers such as `time` or `docker-compose`.

#### Overriding a Commit Rejection

Using the `-f` flag with your git commit will override the pre-commit script
even if it fails the commit will proceed.

#### Further Git Reading

* [Customizing Git - Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
* [githooks.com](http://githooks.com)
