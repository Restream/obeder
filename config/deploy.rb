lock "3.8.0"

set :application, "obeder"
set :repo_url, "git@github.com:Restream/obeder.git"

set :deploy_to, "/root/apps/#{fetch(:application)}"
set :puma_role, :web

append :linked_files, "config/database.yml", "config/secrets.yml", "config/puma.rb"
append :linked_dirs, "tmp/pids", "tmp/sockets", "log"

set :puma_conf, "#{shared_path}/config/puma.rb"

namespace :deploy do
  namespace :assets do
    desc "build frontend"
    task :build_frontend do
      on roles(:web) do
        within release_path do
          execute "yarn"
          execute "npm run build -C #{release_path}"
        end
      end
    end
  end
end

before 'deploy:assets:precompile', 'deploy:assets:build_frontend'
