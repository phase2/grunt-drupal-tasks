#!/bin/bash

# This script creates a working copy of grunt-drupal-tasks by initializing a
# project using the example in the test/working_copy directory.

if [ ! -f "Gruntfile.js" ]; then echo "This script should be run from the grunt-drupal-tasks directory."; exit 1; fi;

# Initialize the working_copy directory
rm -rf test/working_copy
mkdir test/working_copy

# Copy the example skeleton into working_copy
cp -r example/* test/working_copy

# Install dependencies of working_copy
cd test/working_copy
npm install

# Force installation of the checked out version of grunt-drupal-tasks
npm install ../..
