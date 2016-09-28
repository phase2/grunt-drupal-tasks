# Quality

> Maintaining code quality and managing static analysis.

Grunt Drupal Tasks makes a point of easing management of good coding practices
by building code quality checks into the default build process, and applying
several best-of-breed tools to evaluate code changes.

* The `grunt validate` task runs the same operation the build process executes.
* The `grunt analyze` task runs the same, along with the PHP Mess Detector, and
* outputs all results in checkstyle XML format for consumption by Jenkins or
* other reporting tools.

If you are interested in applying validation against files changed in your git
repository, read more on
[how Grunt Drupal Tasks can manage your Git Hooks](70_GIT_INTEGRATION.md).

### Validate Settings

The `validate` task runs eslint, phpcs, phplint against all custom code. If a
theme has it's own `validate` operation configured for grunt, it will skip
eslint.

**validate.ignoreError**: Set to `true` to prevent failing the build if code
quality validation fails (which also prevents other tasks from executing).

#### eslint

Example of eslint configuration:

```
"eslint": {
  "dir": [
    '<%= config.srcPaths.drupal %>/themes/*/js/**/*.js',
    '<%= config.srcPaths.drupal %>/{modules,profiles,libraries}/**/*.js'
  ]
},
```
**eslint**: To enable eslint, set to `true` to use default options or an object
with the following optional settings.

**eslint.configFile**: The path to the eslint config file to use. If no value
is specified, then `.eslintrc` in the project root is used.

**eslint.dir**: An array of glob patterns to include/exclude files for
review by eslint. The following is used by default:

#### PHPLint

**phplint.dir**: An array of globbing patterns which phplint should include or
exclude from PHP code syntax validation.

```
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
```

#### PHPCS

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

> If there is no `phpcs` key in the configuration, the system will assume you
are not using PHPCS and will suppress it from the system.

> The formal coding standards for PHPTemplate files (ending in `.tpl.php`)
seem to be rarely followed or enforced. By default we skip PHPCS processing
of these files.

### Analyze Settings

In addition to all the behaviors under the Validate section, Analyze adds
additional reporting that does not make sense as part of the build process,
such as tools that are too time-consuming to run on a regular basis.

#### PHP Mess Detector (PHPMD)

This tool is less focused on codified practice, and more on the architectural
implications of code complexity, though there is some overlap in the rulesets.

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
