#!/bin/bash

# This script creates a working copy of grunt-drupal-tasks by initializing a
# project using the example in the test/working_copy directory.

if [ ! -f "Gruntfile.js" ]; then echo "This script should be run from the grunt-drupal-tasks directory."; exit 1; fi;

rm -rf test/working_copy
mkdir test/working_copy
cp -r example/* test/working_copy
cd test/working_copy
npm install
npm install ../..
