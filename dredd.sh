#!/bin/bash

# Prepare database
rm app/database/circleci.sqlite
touch app/database/circleci.sqlite
APP_ENV=circleci php artisan db:remigrate

# Start server
APP_ENV=circleci php -S localhost:8003 -t public &
sleep 1


PID=$!
node_modules/.bin/grunt api
node_modules/.bin/grunt dredd
RESULT=$?
kill -9 $PID
exit $RESULT
