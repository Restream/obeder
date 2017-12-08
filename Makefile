.PHONY: docker-setup
docker-setup:
	cp -i secrets.sample.env secrets.env
	docker-compose build
	docker-compose run --rm web bash -c " \
		set -ex; \
		make deps; \
		RAILS_ENV=test bundle exec rake db:drop db:create db:migrate db:seed; \
    RAILS_ENV=development bundle exec rake db:create; \
    make build-assets"

.PHONY: deps
deps:
	bundle install
	yarn install

.PHONY: build-assets
build-assets:
	yarn run build
	bundle exec rails assets:precompile

.PHONY: docker-bash
docker-bash:
	docker-compose run --rm web bash

.PHONY: docker-run
docker-run:
	docker-compose run --rm --service-ports web bash -c " \
		bundle install; \
		bundle exec sidekiq -d -L log/sidekiq.log; \
		clockwork clock.rb & \
		/bin/bash"
