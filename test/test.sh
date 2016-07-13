#!/usr/bin/env bash

set -e

run_tests () {
  echo "*** Running tests for Drupal $GDT_DRUPAL_CORE ***"
  ./test/create_working_copy.sh
  cd test/working_copy/
  grunt --quiet
  grunt drush:liteinstall --quiet
  grunt serve:test >/dev/null &
  until curl -I -XGET -s $GDT_TEST_URL 2>/dev/null | egrep -q '^HTTP.*200'; do sleep 0.5; done
  grunt test
  sleep 1; while (ps aux | grep '[b]ehat' > /dev/null); do sleep 1; done
  for pid in `ps aux | grep drush | grep runserver | awk '{print $2}'`; do echo "Stopping drush pid $pid"; kill -SIGINT $pid; done;
  grunt package --quiet
  # end-to-end tests
  mocha --timeout 10000 node_modules/grunt-drupal-tasks/test/build.js
  # unit tests
  mocha node_modules/grunt-drupal-tasks/test/library.js
}

# Drupal 8
export GDT_DRUPAL_CORE="8" GDT_TEST_URL="http://127.0.0.1:8080/core/misc/drupal.js"
run_tests

# Rinse and repeat
cd ../..

# Drupal 7
export GDT_DRUPAL_CORE="7" GDT_TEST_URL="http://127.0.0.1:8080/misc/drupal.js"
run_tests
