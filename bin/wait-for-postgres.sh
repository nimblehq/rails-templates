#!/bin/sh

set -e

until psql $DATABASE_URL -c "\q" > /dev/null 2>&1; do
  >&2 echo "$DATABASE_URL"
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
