# Y - in response to Would you like to add PhraseApp configuration?
create:
	printf "Y\n" | rails new $(APP_NAME) -m ./template.rb -T ${OPTIONS}

build:
	cd $(APP_NAME) && \
	bin/docker-prepare && \
	docker-compose -f docker-compose.test.yml build

test_variant_app:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml run test

base_addon_spec = spec/addons/base/**/*_spec.rb
web_addon_spec = spec/addons/variants/web/**/*_spec.rb
api_addon_spec = spec/addons/variants/api/**/*_spec.rb

base_spec = spec/base/**/*_spec.rb
web_spec = spec/variants/web/**/*_spec.rb
api_spec = spec/variants/api/**/*_spec.rb

test_template:
	cd $(APP_NAME) && \
	docker-compose -f docker-compose.test.yml up --detach db redis && \
	docker-compose -f docker-compose.test.yml run --detach test bin/start.sh && \
	cd ../.template && \
	bundle install; \
	if [ $(VARIANT) = web ]; then \
		bundle exec rspec --pattern="${base_spec}, ${web_spec}, ${base_addon_spec}, ${web_addon_spec}"; \
	elif [ $(VARIANT) = api ]; then \
		bundle exec rspec --pattern="${base_spec}, ${api_spec}, ${base_addon_spec}, ${api_addon_spec}"; \
	fi;

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create build run cleanup
