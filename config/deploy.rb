lock '3.8.0'

set :application, 'obeder'
set :repo_url, 'git@github.com:Restream/obeder.git'

set :puma_role, :web

append :linked_dirs, 'tmp/pids', 'tmp/sockets', 'log'

namespace :deploy do
  namespace :assets do
    desc 'build frontend'
    task :build_frontend do
      on roles(:web) do
        within release_path do
          execute 'yarn'
          execute "npm run build -C #{release_path}"
        end
      end
    end
  end

  desc 'Restart obeder application'
  task :restart_obeder do
    on roles(:all) do
      execute 'sudo service obeder_puma restart'
      execute 'sudo service obeder_sidekiq restart'
      execute 'sudo service obeder_clockwork restart'
    end
  end
end

before 'deploy:assets:precompile', 'deploy:assets:build_frontend'
after 'deploy:finished', 'deploy:restart_obeder'
