# Deployment Packaging

> Package up the operational codebase to use outside the development scaffolding.

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
