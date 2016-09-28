# Advanced Configuration

> Tips and tricks in customizing Grunt Drupal Tasks, contextually adjusting
behaviors, and more.

## Desktop Notification Settings

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

## Magic Configuration

The domain, project.profile, alias, and siteUrls configurations are all built
using the same system that allows for maximum flexibility in project and
environment configuration. Note that all configuration is subject to the Project
Gruntfile override.

In order of precedence it checks the following:

### Priority 1: Project Gruntfile.js

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

### Priority 2: Environment Variable

Each magic configuration property can also be set via an Environment Variable.

Environment Variables are extremely powerful, but only useful where the
environment contains only a single project using Grunt Drupal Tasks. This is
more effective for dedicated environments, such as official production and
staging servers, or virtual and containerized environments.

The specific environment variable name is covered as part of the property
descriptions.

### Priority 3: Project Gruntconfig.json

The configuration placed in Gruntconfig.json. This is good for straightforward
defaults and is how all *non-magical* configuration works.

If you want to include your task in one of the existing groups, copy the text
exactly as seen in the output of the `grunt help` task.
