Drupal Grunt Build and Testing Tools
===

Code Status (master branch): <img src="https://travis-ci.org/phase2/grunt-drupal-tasks.svg?branch=master">

Requirements
---

* Node.js


Getting started
---

Including in an existing project:

1. Copy Gruntconfig.json, Gruntfile.js, and composer.json from this project's example directory to your project. Add the grunt and grunt-drupal-tasks dependency to your package.json or copy package.json as well.

1. Run "npm install" to install dependencies.

Setting up a new project:

1. In an empty directory, run: npm install --save-dev grunt git+https://github.com/phase2/grunt-drupal-tasks.git

1. Copy the contents of node_modules/grunt-drupal-tasks/example to the project directory.

Supporting the validate task:

1. Create or modify your project's composer.json file to include `squizlabs/php_codesniffer`, `grunt-phpmd`, and `drupal/coder` as demonstrated in example/composer.json

Supporting the package task:

1. Create or modify your project's composer.json file to include `grunt-contrib-compress` as demonstrated in example/composer.json.

Configuration
---

1. Update Gruntconfig.json as needed to specify a custom source or build path or to enable Compass SASS to CSS compilation for custom themes.

1. Update Gruntconfig.json as needed to specify the path to the PHPCS binary and the Drupal Coder module PHPCS standard.


Extending
---

1. Update Gruntfile.js as needed to add build steps or other project-specific actions.

