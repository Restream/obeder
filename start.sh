#!/bin/bash

bundle
rake db:create db:migrate db:seed
rm -f tmp/pids/server.pid
nohup sidekiq &
nohup clockwork clock.rb &
rails s -b '0.0.0.0'
