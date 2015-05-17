# Grunt Drupal Tasks
## A Grunt plugin to automate Drupal build and testing tasks

Code Status (master branch):
[![Travis CI status](https://travis-ci.org/phase2/grunt-drupal-tasks.svg?branch=master)](https://travis-ci.org/phase2/grunt-drupal-tasks)
[![Dependency Status](https://david-dm.org/phase2/grunt-drupal-tasks.svg)](https://david-dm.org/phase2/grunt-drupal-tasks)
[![Peer Dependency Status](https://david-dm.org/phase2/grunt-drupal-tasks/peer-status.svg)](https://david-dm.org/phase2/grunt-drupal-tasks#peer-badge-embed)
[![npm version](https://badge.fury.io/js/grunt-drupal-tasks.svg)](https://www.npmjs.com/package/grunt-drupal-tasks)

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

* Some optional features, used in the included example and end-to-end test
  suite, require additional tools, including <a href="http://bundler.io/">Bundler</a>,
  <a href="https://getcomposer.org/download/">Composer</a>, Ruby, and RubyGems.

## Features

This project is built on the tools of the Grunt community to provide scripted
automation of a number of PHP & Drupal tasks. Here are a few examples of what it
provides:

* Drush make-based build workflow
* CI portability (used with Jenkins so far)
* Opt-in for a number of great enhancements:
  * Composer dependency management for PHP
  * Bundler dependency management for Ruby
  * PHP code quality & static analysis checks
  * Compass compilation
  * Behat testing
* Deployment packaging
* Extensibility: Add or override with your plugins or configuration.

We are continuously working to improve this toolchain, adding functionality that
we see as common to our _continuous integration_ and everyday development
practices.

## Usage

Working on a project that's integrated **grunt-drupal-tasks**? Run `grunt help`
to view documentation tailored for your project.

To build your Drupal site, run `grunt`.

### Special Flags

These flags are not yet documented as part of the `grunt help` command.

* `--quiet`: Suppress desktop notifications.
* `--notify`: Request a desktop notification despite timing or environment settings.
* `--timer`: Output execution time profile at the end of the task run.
* `--concurrency`: Override the dynamic concurrency by Drush Make.

### Environment Options

These environment variables will override other options.
* `GRUNT_DRUPAL_QUIET`: If evaluated truthy, will suppress all desktop notifications.

## Setting Up and Extending

For information on setting up your project with these tools, see
<a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md">CONFIG.md</a>.

For information on extending these tools or contributing changes, see
<a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/EXTEND.md">EXTEND.md</a>.

For information on using these tools with a continuous integration (CI) system,
see <a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/CI.md">CI.md</a>.
