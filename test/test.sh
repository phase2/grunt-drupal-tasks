#!/usr/bin/env bash

set -e
./test/create_working_copy.sh
cd test/working_copy/
grunt --quiet
grunt drush:liteinstall --quiet
grunt drush:runserver >/dev/null &
grunt test
sleep 1; while (ps aux | grep '[b]ehat' > /dev/null); do sleep 1; done
for pid in `ps aux | grep drush | grep runserver | awk '{print $2}'`; do kill -SIGINT $pid; done;
