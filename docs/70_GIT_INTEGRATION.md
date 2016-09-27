# Git Integrations

> Tricks to better manage your project using it's Git version control.

## Adding Git Hooks

The [Git Hook system](http://git-scm.com/docs/githooks) (not to be confused with
the Drupal Hook system), triggers events on certain git interactions. The git
**pre-commit** hook allows us to add a validation step to the commit process
that will block developer's from committing work if it does not get approved by
a script.

Git hook scripts need to be manually installed on a per-repository basis, so
Grunt Drupal Tasks facilitates by allowing easy configuration of the
grunt-githooks plugin as part of our `grunt git-setup` task.

### Default Task

By default, Grunt Drupal Tasks installs a special variant of the `validate`
task. This version, specifically invoked by `validate:staged` attempts to
minimize the number of files scanned by checking only those that have changed
since the last successful commit.

### Configuring Git Hooks

**config.git.hooks**: An array of grunt tasks to run on pre-commit in addition to `validate:staged`.

**config.git.hook-command**: A substitute for a simple `grunt` command to handle the individual grunt tasks.
Allows specification of more complex bin paths or execution wrappers such as `time` or `docker-compose`.

### Overriding a Commit Rejection

Using the `-f` flag with your git commit will override the pre-commit script
even if it fails the commit will proceed.

## Further Git Reading

* [Customizing Git - Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
* [githooks.com](http://githooks.com)
