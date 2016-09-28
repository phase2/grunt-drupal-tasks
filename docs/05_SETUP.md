# Setup Your Environment & Project

> Get Node, Grunt, & Composer squared away, then use Gadget to spin up new projects.

## Requirements

Note that Grunt Drupal Tasks is intended to be compatible with Node.js v4 and
later and PHP v5.5 and later. See the version 0.x series for compatibility with
earlier versions of Node.js and PHP.

### Node.js

Install _Node.js v4.2.x or later_ using [nvm](https://github.com/creationix/nvm),
a [package manager](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager),
or a [standalone installer](http://nodejs.org/download/).

### Grunt

Once _Node.js_ is installed, use _npm_ to install
[grunt-cli](https://github.com/gruntjs/grunt-cli), the Grunt command line interface,
by running:

```
npm install -g grunt-cli
```

### Composer

Some optional features, used in the included example and end-to-end test suite
require additional tools, like [Composer](https://getcomposer.org/download/).

The example template bundles a **composer.json** file that installs supporting
tools, like Behat with the Drupal Extension, PHPMD (PHP Mess Detector), and the
PHP Code Sniffer, among others. By default, the build runs "composer install" to
install these tools. You can modify composer.json to include other dependencies
for your project.

## Start using Gadget

The easiest way to start a new Drupal project with Grunt Drupal Tasks is to use
**[Gadget](https://github.com/phase2/generator-gadget)**, a tool which offers an
interactive, text-based approach to building an initial project template.

Once you have Gadget installed, start a new Drupal project by running
`yo gadget` in an empty directory and answer it's prompts.

```
$> yo gadget

? Machine-name of your project? gadget-test
? One-line project description? My new project.
```

If you wish to customize this structure, you can [override the default practices
with your project configuration](10_BUILD.md),
but will need to manually adjusted generated files to match.

For an example of the default behavior, take a look at the
[example project](https://github.com/phase2/grunt-drupal-tasks/tree/master/example).
