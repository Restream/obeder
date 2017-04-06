role :web, "obeder-1.staging.ul.restr.im"
role :db,  "obeder-1.staging.ul.restr.im"

set :branch, :master
set :rails_env, :production

set :ssh_options, { user: :root }
