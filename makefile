create:
	rails new $(APP_NAME) -m ./rails_docker.rb -T

run:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml run test

smoke-test:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml up && \
  ../bin/wait_for.sh 80

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create run smoke-test cleanup

