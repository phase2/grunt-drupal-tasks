#!/bin/bash

# This script "inverts" the example and root directory so that the current
# checkout of grunt-drupal-tasks is converted into the example project
# inheriting it.

if [ ! -f "Gruntfile.js" ]; then echo "This script should be run from the grunt-drupal-tasks directory."; exit 1; fi;

npm install
mkdir -p node_modules_new/grunt-drupal-tasks
for fn in *; do if [ "$fn" != "node_modules_new" ]; then mv $fn node_modules_new/grunt-drupal-tasks; fi; done
cp -r node_modules_new/grunt-drupal-tasks/example/* .
mv node_modules_new node_modules
npm install grunt@0.4.5
