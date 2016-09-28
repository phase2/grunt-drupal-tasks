# Project Operations

> Operations other than testing involved in the creation, hosting, and
management of a running Drupal site.

## Invoking Ad Hoc Operations

Some of the most common use cases for any Drupal site are the basic operations
of installation, running database updates, and clearing the cache. These are not
difficult operations, but many developers appreciate the common shorthand a
little grunt magic can provide.

To keep this flexible the new Operations system offers nothing out of the box,
but facilitates creating lightweight commands or callouts to the shell for more
advanced scripts you want easily run on the project by the entire team.

This should remind you of the [Frontend & Theming Operations](30_FRONTEND.md).

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

### Pre and Post Operations

Similar to `npm run`, the operations defined in your Gruntconfig will support
`pre-` and `post-` variants. If the main script exists the pre-script will be
triggered first and the post-script will be triggered after. This allows you to
easily extend any project operation with separate grunt, bash, or other tasks.

For example, if you define a new script `update`, you may also configure
`pre-update` and `post-update`.

## Install settings

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

### Pre and Post Installation

The install task has a unique implementation of support for the pre and post
scripts otherwise made available for themes and project operations. This allows
you to implement simple directives or scripts to prepare for installation or
perform non-standardized operations after the main installation routine.

## Serve Settings

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

**serve.port**: The port number to bind for the webserver. Only one service may
occupy a port on a machine, so a project-specific port may be worthwhile.
Defaults to `8080`.

**serve.concurrent**: An array of grunt tasks to be run concurrently to the
server. When run with `serve:demo` or `serve:test` these tasks are not used. By
default they include 'watch-test' and 'watch-theme'. If you use this
configuration to add tasks be sure to include these as they will be suppressed
by any configuration.
