#!/usr/bin/env bash
# Get commit message
commit_message=`cat $1`
if [[ $commit_message =~ ^[[].{1,}[]].{1,}$ ]]
# Commit message format is matched
then
  exit 0
# Commit message format is NOT matched
else
  echo "Commit message format must match: \"[<User Story ID>] Commit message\""
  exit 1
fi
