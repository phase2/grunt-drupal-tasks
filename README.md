# Grunt Drupal Tasks

> A Grunt plugin to automate Drupal 7 and Drupal 8 build and testing tasks.

Code Status (master branch):
[![Travis CI status](https://travis-ci.org/phase2/grunt-drupal-tasks.svg?branch=master)](https://travis-ci.org/phase2/grunt-drupal-tasks)
[![Dependency Status](https://david-dm.org/phase2/grunt-drupal-tasks.svg)](https://david-dm.org/phase2/grunt-drupal-tasks)
[![npm version](https://badge.fury.io/js/grunt-drupal-tasks.svg)](https://www.npmjs.com/package/grunt-drupal-tasks)
[![#grunt-drupal-tasks on Freenode IRC](https://img.shields.io/badge/Freenode%20IRC-%23grunt--drupal--tasks-blue.svg)](https://webchat.freenode.net/?channels=grunt-drupal-tasks)

## Features

This project is built on the tools of the Grunt community to provide scripted
automation of a number of PHP & Drupal tasks. Here are a few examples of what it
provides:

* Configurable code structure that defaults to a clean development practice.
* Composer [build workflow](docs/10_BUILD.md)
  (or Drush make-based build workflow for Drupal 7.x).
* Optional use [Code Quality & Static Analysis](docs/20_QUALITY.md),
  and [Frontend tooling](docs/30_FRONTEND.md)
  to extend the build process.
* [Behat and SimpleTest Testing](docs/40_TESTING.md)
* [Deployment packaging](docs/60_PACKAGE.md)
* [Git Hook management](docs/70_GIT_INTEGRATION.md)
* Desktop Notifications
* Local Development Friendly
* [CI](docs/80_CI.md) Friendly

We are continuously working to improve this toolchain, adding functionality that
we see as common to our _continuous integration_ and everyday development
practices.

## Requirements

For requirements, installation, use, and customization instructions, see the [documentation](https://phase2.github.io/grunt-drupal-tasks).
