#!/bin/bash

bundle check || bundle install

bundle exec rspec $@ # adds any rspec args passed down from CLI
