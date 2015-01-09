#!/usr/bin/env bash

set -e
./test/create_working_copy.sh
cd test/working_copy/
grunt --quiet
grunt drush:liteinstall --quiet
grunt drush:runserver &
grunt test

