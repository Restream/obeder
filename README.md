# README

[![Build Status](https://travis-ci.org/Restream/obeder.svg?branch=develop)](https://travis-ci.org/Restream/obeder)

## Setup
 * docker-compose up
 * docker-compose exec web yarn
 * docker-compose exec web yarn build

 Если возникает ошибка `ERROR: Couldn't find env file: /Users/maksim/Workspace/obeder/secrets.env`,
 берем файлик secrets.sample.env, копируем его и соответствующим образом называем.

## EZ deploy

Download and install the Heroku CLI. (brew install heroku or download pkg)
 * heroku login
 * heroku git:remote -a obeder

Deploy:
 * heroku buildpacks:add heroku/nodejs
 * heroku buildpacks:add heroku/ruby
 * heroku config:set NPM_CONFIG_PRODUCTION=false
 * heroku addons:create heroku-postgresql:hobby-dev
 * heroku addons:create sendgrid:starter
 * git push heroku master

## Frontend

* npm run dev - watching changes and recompiling bundle (also runs development server on 8080 port)

## Sidekiq & Clockwork

* docker-compose run --rm web sidekiq
* docker-compose run --rm web clockwork clock.rb

## Закинуть базу в кубер

- на проде (ssh deployer@obeder-1.staging.ul.restr.im)
* pg_dump -xc -O  obeder_production -U postgres | gzip > obeder.sql.gz
- на своей тачке
* scp deployer@obeder-1.staging.ul.restr.im:obeder.sql.gz obeder.sql.gz
* kubectl cp obeder.sql.gz obeder/db-2830043074-s18jf:/obeder.sql.gz
- в контейнере базы (kubectl exec db-2830043074-s18jf bash --namespace=obeder -it)
* SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'obeder_production' AND pid <> pg_backend_pid();
* drop database obeder_production;
* create database obeder_production;
* zcat obeder.sql.gz | psql -U postgres obeder_production

## Задеплоить в кубер
* docker-compose build
* docker tag obeder_web docker-registry.restr.im:5000/obeder/web:1
* docker push docker-registry.restr.im:5000/obeder/web:1
* set image deployment/web obeder=docker-registry.restr.im:5000/obeder/web:1
