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
are specified it will default to `http://<%= config.domain %>`.

```
  "siteUrls": {
    "default": "http://dev-site.local",
    "subsite": "http://sub.dev-site.local"
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

### Performance Testing

```
{
  "performance": {
    "samplePaths": [
      "/",
      "about",
    ],
    "pagespeed": {
      "threshold": {
        "desktop": 100,
        "mobile": 95
      }
    }
  }
}
```

* **samplePaths**: An array of paths to iterate across for basic performance
  checks. Defaults to the site homepage.
* **pagespeed.threshold**: Specify the scores for desktop and mobile pagespeed
  evaluation. If the score is not met it will fail.

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


#### Environment Variables

**GDT_QUIET**: This will suppress all notifications from all tasks unless the
`--notify` flag is used.

### Theme Settings

This is an example of the settings for theme tasks:

```
{
  "themes": {
    "spartan": {
      "path": "<%= config.srcPaths.drupal %>/themes/spartan",
      "compass": true
    }
  }
}
```

**themes**: Defines each custom Drupal theme and enables features, like Sass
processing by Compass.

**themes.\<theme\>.compass**: Enable compass preprocessing. Either `true` to 
enable with default compass options, or a configuration object to be passed 
directly to 
[grunt-contrib-compass](https://github.com/gruntjs/grunt-contrib-compass)
for this theme.

#### Setting Up Gem Dependencies

In order for compass compilation to work, you will need to create a Gemfile
at your project root. The presence of this Gemfile will activate the `grunt
bundle-install` task and automatically add it to the build process.

A typical Gemfile focused on SASS support might look like the following:

```ruby
source 'https://rubygems.org'

gem 'sass', '~>3.3.0'
gem 'compass', '~> 1.0.1'
gem 'json', '~>1.8.2'
```

### Validate Settings

This is an example of the settings for the validate tasks:

```
{
  "phpcs": {
    "path": "bin/phpcs",
    "standard": "vendor/drupal/coder/coder_sniffer/Drupal"
  }
  "phplint": {
    "dir": [
      "<%= config.srcPaths.drupal %>/**/*.php",
      "<%= config.srcPaths.drupal %>/**/*.module",
      "<%= config.srcPaths.drupal %>/**/*.inc",
      "<%= config.srcPaths.drupal %>/**/*.install",
      "<%= config.srcPaths.drupal %>/**/*.profile",
      "!<%= config.srcPaths.drupal %>/**/vendor/**",
    ]
  }
}
```

> If there is no `phpcs` key in the configuration, the system will assume you
are not using PHPCS and will suppress it from the system.

**phpcs.path**: The path to the PHPCS executable.

**phpcs.standard**: The PHPCS coding standard to use. The example composer.json
installs the Drupal Coder's standard, the path of which is shown above.

**phpcs.dir**: An array of globbing pattern where phpcs should search for files.
This can be used to replace the defaults supplied by grunt-drupal-tasks.

This example placed in the Gruntconfig.json file ignores directories named 
"pattern-lab" and a "bower_components" in addition to the defaults that come with
grunt-drupal-tasks:

```
{
  "phpcs": {
    "path": "vendor/bin/phpcs",
    "dir": [
      "<%= config.srcPaths.drupal %>/**/*.php",
      "<%= config.srcPaths.drupal %>/**/*.module",
      "<%= config.srcPaths.drupal %>/**/*.inc",
      "<%= config.srcPaths.drupal %>/**/*.install",
      "<%= config.srcPaths.drupal %>/**/*.profile",
      "!<%= config.srcPaths.drupal %>/sites/**",
      "!<%= config.srcPaths.drupal %>/**/*.box.inc",
      "!<%= config.srcPaths.drupal %>/**/*.features.*inc",
      "!<%= config.srcPaths.drupal %>/**/*.pages_default.inc",
      "!<%= config.srcPaths.drupal %>/**/*.panelizer.inc",
      "!<%= config.srcPaths.drupal %>/**/*.strongarm.inc",
      "!<%= config.srcPaths.drupal %>/**/*.css",
      "!<%= config.srcPaths.drupal %>/**/*/pattern-lab/**/*",
      "!<%= config.srcPaths.drupal %>/**/*/bower_components/**/*"
    ]
  }
}
```

**phpcs.ignoreExitCode**: Set to `false` if you want validate to fail on PHPCS
issues.

**phplint.dir**: An array of globbing patterns which phplint should include or
exclude from PHP code syntax validation.

### Package Settings

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

### Help Settings (Help API)

If you add custom tasks to your project and want them exposed as part of the
`help` task, you may add a simple code snippet to your Gruntfile.js or any loaded
task file.

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

### External Tools

There are a number of tools you might choose to use as part of build or testing
that leverage remotely hosted services (Google Pagespeed, WebPageTest.org), in
those cases you should run with one of the following options.

_(Note that these options are all based on individual tasks implementing proper
support, for a new task in your system consider this a standard implementation
practice rather than a feature to be relied upon.)_

#### Command Flag
* **--web-ready**: This command-line option sets the system to treat the site
as web accessible.

#### Environment Variable

* **GDT_WEB_READY**: All grunt commands will be treated as run with the
`--web-ready` flag by default.

