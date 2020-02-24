create:
	rails new $(APP_NAME) -m ./template.rb -T ${OPTIONS}

build:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml build

run:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml run test

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create build run cleanup
