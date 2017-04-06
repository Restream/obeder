set :host, "obeder-1.staging.ul.restr.im"
role :web, fetch(:host)
role :db,  fetch(:host)

set :branch, :master
set :rails_env, :production

set :ssh_options, { user: :root }
