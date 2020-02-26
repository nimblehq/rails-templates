create:
	rails new $(APP_NAME) -m ./template.rb -T ${OPTIONS}

build:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml build

run:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml run test

base_spec = spec/base/**/*_spec.rb,spec/addons/docker/**/*_spec.rb
test:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml up --detach db redis && \
	docker-compose -f docker-compose.test.yml run --detach test bin/start.sh && \
	cd ../.template && \
	bundle install; \
	if [ $(VARIANT) = web ]; then \
	  bundle exec rspec --pattern="$(base_spec),spec/variants/web/**/*_spec.rb"; \
	elif [ $(VARIANT) = api ]; then \
	  bundle exec rspec --pattern="$(base_spec),spec/variants/api/**/*_spec.rb"; \
	fi;

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create build run cleanup
