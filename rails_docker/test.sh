#!/bin/bash

bundle check || bundle install

bundle exec rspec $1
