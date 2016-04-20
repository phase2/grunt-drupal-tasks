# Frontend & Theme Operations

> Facilitate integration with Drupal themes as owners of their own script-driven tooling.

## Making Grunt Theme-Aware

For each theme Grunt should be aware of, it will need an entry in the `Gruntconfig.json` under the themes property. This might look like the following:

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

## Theme Scripts

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
Project Operations. This means if you configure a `compile-theme` task in `Gruntconfig.json`, you may also configure a `pre-compile-theme` and a `post-compile-theme`.
