set :host, 'obeder-1.staging.ul.restr.im'
role :web, fetch(:host)
role :db,  fetch(:host)

set :branch, :master
set :rails_env, :production

set :user, 'root'
set :ssh_options, user: fetch(:user)

set :deploy_to, "/root/apps/#{fetch(:application)}"
