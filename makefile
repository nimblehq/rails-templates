create:
	rails new $(APP_NAME) -m ./template.rb -T ${OPTIONS}

run:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml run test

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create run cleanup

