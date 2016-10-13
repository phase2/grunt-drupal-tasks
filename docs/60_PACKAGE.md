# Deployment Packaging

> Package up the operational codebase to use outside the development scaffolding.

The `grunt package` task allows you to assemble and independently exported
Drupal codebase. This is used to facilitate deployment of the minimal code
needed to run Drupal in a formal environment such as Production.

## Default Packaging

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

## Packaging Customization

**packages.srcFiles**: An array of files or file patterns to include or exclude
from the build output when building a package. The above excludes files within
any sites/*/files directory, and Drupal's xmlrpc.php and PHP Filter. For more on
this format, see: http://gruntjs.com/configuring-tasks#files

**packages.projFiles**: An array of files or file patterns to include or exclude
from the project directory when building a package. The above includes README
files and files under bin/ in the project's package.

**packages.dest.docroot**: Specify where within the package directory the
`srcFiles` should be placed. Defaults to the package root. For Acquia set this
to 'docroot'.

**packages.dest.vendor**: Specify where to place the composer.json and vendor
directory.  Defaults to the docroot.

**packages.dest.devResources**: Specify where within the package directory the
`projFiles` should be placed. Defaults to package root.

**packages.name**: The default name of the package, used as the path within the
packages directory. This can be overridden by calling grunt package with the
`--name` parameter.

**archive**: Used to enable the `compress` option via the configuration instead
of the command line. Defaults to false.

**rsync**: If set to true, rsync will be used instead of file copying for
improved performance. This automatically enables the `compress` option and will
write the archive to the package destination.

**vmData**: This path is used as the intermediate generation directory for the
package when using the `rsync` option. By selecting a volume mounted in your
VM `/data` area, this can significantly improve performance. The archive is
still moved to the normal package destination when complete.  Defaults to
`build/vm_data`.

## Performance

When running `grunt package` within a docker container, the default file
operations will be using NFS to update the files on your local disk, which will
be very slow. Using the `rsync` option along with creating the `build/vm_data`
intermediate mount point in your docker container can improve performance by
a factor of 20 or more. However, the downside is only the compressed archive of
your package will be written to your local disk. The full package folder will
only be accessible within your docker container.

A sample docker-composer.yml entry to mount the vm_data looks like this:
```
  volumes:
    - /data/PROJECTNAME/package:/var/www/build/vm_data
```

## Packaging for Acquia

The `package` command has the flexibility to support many different use cases,
include structure for PaaS services such as Acquia. This is currently handled
by convention rather than specific coded support.

The example configuration below for your Gruntconfig.json file structures an
Acquia repository with support for custom hooks and scripts.

```
{
  "packages": {
    "srcFiles": ["!sites/*/files/**", "!xmlrpc.php", "!modules/php/*"],
    "projFiles": ["README*", "bin/**", "hooks/**"],
    "rsync": true,
    "dest": {
      "docroot": "docroot"
    }
  }
}
```
