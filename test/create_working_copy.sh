#!/bin/bash

# This script creates a working copy of grunt-drupal-tasks by initializing a
# project using the example in the test/working_copy directory.

if [ ! -f "Gruntfile.js" ]; then echo "This script should be run from the grunt-drupal-tasks directory."; exit 1; fi;

# If an old install exists, reset permissions on src/sites/default.
if [ -d "test/working_copy/src/sites/default" ]; then chmod 755 test/working_copy/src/sites/default/; fi;

# Initialize the working_copy directory
rm -rf test/working_copy
mkdir test/working_copy
PATH_WORKING_COPY="`pwd`/test/working_copy"

# Copy the example skeleton into working_copy
cp -r example/. $PATH_WORKING_COPY

# Copy the test assets into working_copy
PATH_TEST_ASSETS="test/test_assets"
if [[ $GDT_DRUPAL_CORE == "8" ]]; then PATH_TEST_ASSETS="test/test_assets_d8"; fi;
cd $PATH_TEST_ASSETS
for file in `find . -type f`; do mkdir -p $PATH_WORKING_COPY/`dirname $file`; cp $file $PATH_WORKING_COPY/$file; done;

# Install dependencies of working_copy
cd $PATH_WORKING_COPY
npm install

# Force installation of the checked out version of grunt-drupal-tasks
npm install ../..
