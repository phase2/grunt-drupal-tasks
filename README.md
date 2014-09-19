# Drupal Grunt Build and Testing Tools

Code Status (master branch): <img src="https://travis-ci.org/phase2/grunt-drupal-tasks.svg?branch=master">

## Requirements

* Node.js


## Features

This project is built on the tools of the grunt community to provide scripted automation of a number of PHP & Drupal tasks from wrangling the UI all the way down to build & deployment processes. Here are just a few examples of what it provides:

* PHP code quality checks
* Compass compilation
* Drush make-based build workflow
* Deployment packaging
* Behat testing
* Jenkins support
* Extensibility: Add or override anything with your own plugins or configuration.

We are continuously working to improve this toolchain, adding functionality that we see as common to our _continuous integration_ and everyday development practices.

## Getting started

If you would like to use grunt-drupal-tasks, be prepared to use it as a dependency and light framework for your project's use of grunt.

### Add to an existing project

1. Copy Gruntconfig.json, Gruntfile.js, and composer.json from this project's example directory to your project. Add the grunt and grunt-drupal-tasks dependency to your package.json or copy package.json as well.

2. Run "npm install" to install dependencies.

### Set up a new project

1. In an empty directory, run: npm install --save-dev grunt git+https://github.com/phase2/grunt-drupal-tasks.git

2. Copy the contents of node_modules/grunt-drupal-tasks/example to the project directory.

## Task-specific dependencies

### Supporting the validate and analyze tasks

* Create or modify your project's composer.json file to include `squizlabs/php_codesniffer`, `grunt-phpmd`, and `drupal/coder` as demonstrated in example/composer.json


## Configuration

1. Update Gruntconfig.json as needed to specify a custom source or build path or to enable Compass SASS to CSS compilation for custom themes.

1. Update Gruntconfig.json as needed to specify the path to the PHPCS binary and the Drupal Coder module PHPCS standard.


Extending
---

1. Update Gruntfile.js as needed to add build steps or other project-specific actions.

