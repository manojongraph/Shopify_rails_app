# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :stages, %w(staging production)
set :default_stage, 'staging'

set :application, "PaySafTrack"

# config/deploy.rb

namespace :deploy do
  desc 'Install gems using Bundler'
  task :run_bundle_install do
    on roles(:app) do
      within release_path do
        execute :rbenv, 'local', fetch(:rbenv_ruby) # Set the Ruby version
        execute :bundle, 'install' # Run bundle command
      end
    end
  end
  
  

  desc 'Run database migrations'
  task :run_migrations do
    on roles(:db) do
      within release_path do
        execute '/home/ubuntu/.asdf/shims/rails', 'db:migrate'
      end
    end
  end
  

  # desc 'Start the Rails server'
  # task :start_server do
  #   on roles(:app) do
  #     within release_path do
  #       execute '/home/ubuntu/.asdf/shims/bundle', 'exec rails server -e production -d'
  #     end
  #   end
  # end

  # Specify task order
  after 'deploy:symlink:release', 'deploy:run_bundle_install'
  after 'deploy:run_bundle_install', 'deploy:run_migrations'
  # after 'deploy:run_migrations', 'deploy:start_server'
end


# set :repo_url, "git@example.com:me/my_repo.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
