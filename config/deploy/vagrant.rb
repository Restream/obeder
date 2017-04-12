set :host, '10.10.10.10'
role :web, fetch(:host)
role :db,  fetch(:host)

set :branch, :master
set :rails_env, :production

set :ssh_options, user: :vagrant, forward_agent: true, auth_methods: %w(publickey password)
