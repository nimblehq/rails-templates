#!/bin/bash

if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi

# Runs migrations if any pending
rails db:migrate

bundle exec rails s -p $PORT -b 0.0.0.0
