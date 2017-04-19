set :host, '10.10.10.10'
role :web, fetch(:host)
role :db,  fetch(:host)

set :branch, :master
set :rails_env, :production

set :user, 'vagrant'
set :homedir, "/home/#{fetch(:user)}"
set :ssh_options, user: fetch(:user)

set :deploy_to, "#{fetch(:homedir)}/apps/#{fetch(:application)}"
