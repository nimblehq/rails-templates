include .env

.PHONY: dev env/setup env/teardown codebase codebase/fix

dev:
	make install-dependencies
	make env/setup
	foreman start -f Procfile.dev

env/setup:
	./bin/envsetup.sh
	rails db:prepare

env/teardown:  # this command will delete data
	./bin/envteardown.sh

install-dependencies:
	bundle install
	yarn install

codebase:
	rubocop
	yarn codebase

codebase/fix:
	rubocop -a
	yarn codebase:fix
