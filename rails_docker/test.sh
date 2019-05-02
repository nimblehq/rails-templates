#!/bin/bash

# Exit on fail
set -e

bundle check || bundle install

bundle exec rspec $@ # adds any rspec args passed down from CLI
