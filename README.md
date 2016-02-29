# Grunt Drupal Tasks
## A Grunt plugin to automate Drupal build and testing tasks

Code Status (master branch):
[![Travis CI status](https://travis-ci.org/phase2/grunt-drupal-tasks.svg?branch=master)](https://travis-ci.org/phase2/grunt-drupal-tasks)
[![Dependency Status](https://david-dm.org/phase2/grunt-drupal-tasks.svg)](https://david-dm.org/phase2/grunt-drupal-tasks)
[![Peer Dependency Status](https://david-dm.org/phase2/grunt-drupal-tasks/peer-status.svg)](https://david-dm.org/phase2/grunt-drupal-tasks#peer-badge-embed)
[![npm version](https://badge.fury.io/js/grunt-drupal-tasks.svg)](https://www.npmjs.com/package/grunt-drupal-tasks)

## Requirements

> Note that Grunt Drupal Tasks is intended to be compatible with Node.js v4 and
v0.12 and npm v2. Grunt Drupal Tasks may not work with Node.js v5 and npm v3.

* Install _Node.js v0.12.x or v4.3.x_ either using a
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

## Quickstart

We have a [Yeoman](http://yeoman.io) generator that can quickly take you from an
empty directory to a running Drupal site using this toolchain.

Please welcome [Gadget](https://github.com/phase2/generator-gadget)!

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
* Git Hook management
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
* `--no-validate`: Skip `grunt:validate` in the default `grunt` task.

### Environment Options

These environment variables will override other options.

* `GDT_DOMAIN`: Specify the base URL for live system testing. Falls back to a
setting in the project's Gruntconfig.json, then hostname if not set.
* `GDT_INSTALL_PROFILE`: Overrides the install profile specified in the
project's Gruntconfig.json to be used by the `install` task.
* `GDT_QUIET`: If evaluated truthy, will suppress all desktop notifications.
* `GDT_SITE_ALIAS`: Configure the default Drush site alias for the project.
* `GDT_SITEURLS`: Overrides the URL(s) for the project's site(s) specified in
the Gruntconfig.json by which each can be accessed for end-to-end testing by
tools such as Behat. Use instead of `GDT_DOMAIN` if the project has multiple
subsites or URLs.

## Setting Up and Extending

For information on setting up your project with these tools, see
<a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/CONFIG.md">CONFIG.md</a>.

For information on extending these tools or contributing changes, see
<a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/EXTEND.md">EXTEND.md</a>.

For information on using these tools with a continuous integration (CI) system,
see <a href="https://github.com/phase2/grunt-drupal-tasks/blob/master/CI.md">CI.md</a>.
