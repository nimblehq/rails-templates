create:
	rails new $(APP_NAME) -m ./template.rb -T

run:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml run test

smoke-test:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml up && \
  ../.template/bin/wait_for.sh 80

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create run smoke-test cleanup

