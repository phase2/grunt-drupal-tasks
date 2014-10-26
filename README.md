# Drupal Grunt Build and Testing Tasks

Code Status (master branch):
<a href="https://travis-ci.org/phase2/grunt-drupal-tasks"><img src="https://travis-ci.org/phase2/grunt-drupal-tasks.svg?branch=master"></a>

## Requirements

* Install _Node.js v0.10.0 or better_ either using a
<a href="https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager">package manager</a>
like apt-get, brew, or yum or a
<a href="http://nodejs.org/download/">standalone installer</a>.

* Once _Node.js_ is installed, use _npm_ to install
<a href="https://github.com/gruntjs/grunt-cli">grunt-cli</a>, the Grunt command
line interface, by running:

```
npm install -g grunt-cli
```

## Features

This project is built on the tools of the Grunt community to provide scripted
automation of a number of PHP & Drupal tasks. Here are a few examples of what it
provides:

* PHP code quality checks
* Compass compilation
* Drush make-based build workflow
* Deployment packaging
* Behat testing
* Jenkins support
* Extensibility: Add or override anything with your plugins or configuration.

We are continuously working to improve this toolchain, adding functionality that
we see as common to our _continuous integration_ and everyday development
practices.

## More information

For information on integrating these tools with your project, see
<a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md">CONFIG.md</a>.

If your project is already using these tools, use **grunt help** to get
information on available tasks.

For information on extending these tools or contributing changes, see
<a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/EXTEND.md">EXTEND.md</a>.
