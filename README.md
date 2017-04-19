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
