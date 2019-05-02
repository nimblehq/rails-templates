create:
	rails new $(APP_NAME) -m ./rails_docker.rb -T

build:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml build

rspec:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml run test

ports:
	./bin/wait_for.sh 3000

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create build test ports cleanup

