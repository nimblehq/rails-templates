#!/bin/bash

echo "Waiting service to launch on port $1"

nc -v -z -w 3 localhost $1 &> /dev/null && exit 0 || exit 1
